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
    }
    
    private func bind() {
        cancellables.insert(
            photoGalleryViewModel.navigateToDetail
                .sink { print("navigate") }
        )
    }
}

