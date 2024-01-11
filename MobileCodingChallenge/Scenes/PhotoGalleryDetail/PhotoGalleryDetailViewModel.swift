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
}

final class PhotoGalleryDetailViewModel: PhotoGalleryDetailViewModelProtocol,
                                         ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    
    var photos: [PhotoDetailModel]
    var selectedImageIndex: Int
    
    init(photos: [PhotoDetailModel], selectedImageIndex: Int) {
        self.photos = photos
        self.selectedImageIndex = selectedImageIndex
    }
}

