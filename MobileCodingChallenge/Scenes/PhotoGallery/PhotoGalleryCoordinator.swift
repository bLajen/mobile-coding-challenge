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
    
    private let photoGalleryViewModel = PhotoGalleryViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    @ViewBuilder
    func start() -> some View {
        PhotoGalleryView(viewModel: photoGalleryViewModel)
    }
    
    private func bind() {
        cancellables.insert(
            photoGalleryViewModel.didItemSelectAt
                .sink { [weak self] indexPath in self?.showDetailView(selectedImageIndex: indexPath.item) }
        )
    }
    
    private func showDetailView(selectedImageIndex: Int) {
        let detailModel = photoGalleryViewModel.photos.map { PhotoDetailModel(id: $0.id,
                                                                              createdAt: $0.createdAt,
                                                                              altDescription: $0.altDescription,
                                                                              width: $0.width,
                                                                              height: $0.height,
                                                                              urls: $0.urls) }
        let viewModel = PhotoGalleryDetailViewModel(photos: detailModel,
                                                    selectedImageIndex: selectedImageIndex)
        push(.detail(viewModel: viewModel))
    }
}

