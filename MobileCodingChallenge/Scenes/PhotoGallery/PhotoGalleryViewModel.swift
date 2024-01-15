//
//  PhotoGalleryViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import Combine
import SwiftUI

typealias Snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResponse>

//Required properties and functions for the view model
protocol PhotoGalleryViewModelProtocol {
    var snapshot: Snapshot { get }
    var orientation: UIDeviceOrientation { get }
}
final class PhotoGalleryViewModel: PhotoGalleryViewModelProtocol,
                                   ObservableObject {
    @Published var collectionViewModel: CollectionViewModel
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    @Published var snapshot: Snapshot = {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([0])
        return initialSnapshot
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private var isLoading = false
    
    // Photos service request params
    private var page: Int
    private let perPage: Int
    
    init(updateScrollPosition: PassthroughSubject<Int, Never> = PassthroughSubject<Int, Never>()) {
        page = 1
        perPage = 30
        
        self.collectionViewModel = CollectionViewModel(updateScrollPosition: updateScrollPosition)
        
        getPhotos()
        bind()
    }
    
    private func bind() {
        cancellables.insert(
            collectionViewModel.fetchMoreGalleryItem
                .sink { [weak self] in self?.getPhotos() }
        )
    }
    
    //Request random photos from the service
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
                self?.snapshot.appendItems(response)
                self?.page += 1
                self?.collectionViewModel.updateDataSource(models: response)
            }
            .store(in: &cancellables)
    }
}
