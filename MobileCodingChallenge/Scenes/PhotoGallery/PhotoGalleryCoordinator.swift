//
//  PhotoGalleryCoordinator.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import Combine
import SwiftUI

final class PhotoGalleryCoordinator: Coordinator {
    @Published var path = NavigationPath()
    
    private(set) var photoGalleryDetailViewModel: PhotoGalleryDetailViewModel
    private let photoGalleryViewModel: PhotoGalleryViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let imageIndexChanged = PassthroughSubject<Int, Never>()
    
    init() {
        photoGalleryViewModel = PhotoGalleryViewModel(updateScrollPosition: imageIndexChanged)
        photoGalleryDetailViewModel = PhotoGalleryDetailViewModel(photos: [], selectedImageIndex: 0)
        
        bind()
    }
    
    @ViewBuilder
    func start() -> some View {
        PhotoGalleryView(viewModel: photoGalleryViewModel)
    }
    
    private func bind() {
        cancellables.insert(
            photoGalleryViewModel
                .collectionViewModel
                .didItemSelectAt
                .sink { [weak self] indexPath in self?.showDetailView(selectedImageIndex: indexPath.item) }
        )
    }
    
    func showDetailView(selectedImageIndex: Int) {
        let detailModel = photoGalleryViewModel.collectionViewModel.photos
            .map { PhotoDetailModel(id: $0.id,
                                    createdAt: $0.createdAt,
                                    altDescription: $0.altDescription,
                                    width: $0.width,
                                    height: $0.height,
                                    urls: $0.urls) }
        
        photoGalleryDetailViewModel = PhotoGalleryDetailViewModel(photos: detailModel,
                                                                  selectedImageIndex: selectedImageIndex)
        cancellables.insert(
            photoGalleryDetailViewModel.updateScrollPosition
                .sink { [weak self] index in
                    self?.imageIndexChanged.send(index) }
        )
        
        
        push(.detail(viewModel: photoGalleryDetailViewModel))
    }
}
