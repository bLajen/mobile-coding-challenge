//
//  PhotoGalleryDetailCoordinator.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import SwiftUI

final class PhotoGalleryDetailCoordinator: Coordinator {
    @Published var path = NavigationPath()
    
    private let photoGalleryDetailViewModel: PhotoGalleryDetailViewModel
    
    init(photoGalleryDetailViewModel: PhotoGalleryDetailViewModel) {
        self.photoGalleryDetailViewModel = photoGalleryDetailViewModel
    }
    
    @ViewBuilder
    func start() -> some View {
        PhotoGalleryDetailView(viewModel: photoGalleryDetailViewModel)
    }
}
