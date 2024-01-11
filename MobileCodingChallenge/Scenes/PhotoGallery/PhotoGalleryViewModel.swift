//
//  PhotoGalleryViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import Combine
import SwiftUI

typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResponse>

protocol PhotoGalleryViewModelProtocol {
    var snapshot: Snapshot { get }
    var photos: [PhotoResponse] { get }
    var orientation: UIDeviceOrientation { get }
    var fetchMoreGalleryItem: PassthroughSubject<Void, Never> { get }
    var didItemSelectAt: PassthroughSubject<IndexPath, Never> { get }
}

final class PhotoGalleryViewModel: PhotoGalleryViewModelProtocol,
                                   ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    @Published var photos: [PhotoResponse] = []
    @Published var snapshot: Snapshot = {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([0])
        return initialSnapshot
    }()
    
    let didItemSelectAt = PassthroughSubject<IndexPath, Never>()
    let fetchMoreGalleryItem = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    
    // Photos service request params
    private var page = 1
    private let perPage = 40
    
    init() {
        getPhotos()
        bind()
    }
    
    func getPhotos() {
        guard !isLoading else { return }
        
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
                self?.isLoading = false
                self?.photos.append(contentsOf: response)
                self?.snapshot.appendItems(response)
                self?.page += 1
            }
            .store(in: &cancellables)
    }
    
    private func bind() {
        cancellables.insert(
            fetchMoreGalleryItem
                .sink { [weak self] in self?.getPhotos() }
        )
    }
}
