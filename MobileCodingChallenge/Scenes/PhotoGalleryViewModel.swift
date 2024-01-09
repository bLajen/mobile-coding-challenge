//
//  PhotoGalleryViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import Combine

protocol PhotoGalleryViewModelProtocol {
    var navigateToDetail: PassthroughSubject<Void, Never> { get }
}

class PhotoGalleryViewModel: PhotoGalleryViewModelProtocol, ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let navigateToDetail = PassthroughSubject<Void, Never>()
}
