//
//  PhotoGalleryView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject var viewModel: PhotoGalleryViewModel
    
    let cellRegistration: UICollectionView.CellRegistration = .hosting { (idx: IndexPath, item: PhotoResponse) in
        let viewModel = GalleryCellViewModel(item: item)
        return GalleryCell(viewModel: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            CollectionView(snapshot: viewModel.snapshot,
                           viewModel: viewModel.collectionViewModel,
                           orientation: $viewModel.orientation,
                           collectionViewLayout: collectionViewCustomLayout(),
                           cellProvider: cellProvider)
        }
        .onRotate { newOrientation in
            viewModel.orientation = newOrientation
        }
    }
}

// MARK: - Collection View

extension PhotoGalleryView {
    func collectionViewCustomLayout() -> CollectionViewCustomLayout {
        CollectionViewCustomLayout(orientation: $viewModel.orientation)
    }
    
    func cellProvider(_ collectionView: UICollectionView,
                      indexPath: IndexPath,
                      item: PhotoResponse) -> UICollectionViewCell {
        collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                     for: indexPath,
                                                     item: item)
    }
}
