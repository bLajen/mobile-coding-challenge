//
//  PhotoGalleryViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import Combine
import SwiftUI

protocol PhotoGalleryViewModelProtocol {
    var navigateToDetail: PassthroughSubject<Void, Never> { get }
    var photos: [PhotoResponse] { get }
}

final class PhotoGalleryViewModel: PhotoGalleryViewModelProtocol, ObservableObject {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResponse>
    
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    @Published var photos: [PhotoResponse] = []
    @Published var snapshot: Snapshot = {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([0])
        return initialSnapshot
    }()
    
    let navigateToDetail = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    
    // Photos service request params
    private var page = 1
    private let perPage = 20
    
    init() {
        getPhotos()
    }
    
    func getPhotos() {
        let service = PhotosService.shared
        let clientId = Constant.clientID.rawValue
        let page = String(page)
        let perPage = String(perPage)
        
        let params = PhotosParams(clientId: clientId,
                                  page: page,
                                  perPage: perPage)
        
        service
            .getPhotos(params: params)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .finished: break
                case let .failure(error):
                    print(error) // TODO: Error handling
                }
            } receiveValue: { [weak self] response in
                self?.photos.append(contentsOf: response)
                self?.page += 1
            }
            .store(in: &cancellables)
    }
}
