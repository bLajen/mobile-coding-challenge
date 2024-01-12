//
//  PhotoGalleryDetailViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import Combine
import SwiftUI

protocol PhotoGalleryDetailViewModelProtocol {
    var photos: [PhotoDetailModel] { get }
    var selectedImageIndex: Int { get }
    var orientation: UIDeviceOrientation { get }
    var updateScrollPosition: PassthroughSubject<Int, Never> { get }
}

final class PhotoGalleryDetailViewModel: PhotoGalleryDetailViewModelProtocol,
                                         ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    @Published var selectedImageIndex: Int
    
    let updateScrollPosition = PassthroughSubject<Int, Never>()
    var photos: [PhotoDetailModel]
    
    init(photos: [PhotoDetailModel], selectedImageIndex: Int) {
        self.photos = photos
        self.selectedImageIndex = selectedImageIndex
    }
    
    func imageIndexChanged(indexPath: Int) {
        updateScrollPosition.send(indexPath)
    }
}

