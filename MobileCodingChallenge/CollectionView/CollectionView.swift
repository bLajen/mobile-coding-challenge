//
//  CollectionView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-10.
//

import SwiftUI
import Combine

struct CollectionView<SectionType, ItemType>
where SectionType: Hashable & Sendable,
      ItemType: Hashable & Sendable {
    typealias BaseCollectionView = CoreCollectionView<SectionType, ItemType>
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>
    
    @ObservedObject var viewModel: CollectionViewModel
    
    //CollectionView configuration properties
    private let cellProvider: DataSource.CellProvider
    private let snapshot: Snapshot
    private let collectionViewLayout: CollectionViewCustomLayout
    
    init(snapshot: Snapshot,
         viewModel: CollectionViewModel,
         orientation: Binding<UIDeviceOrientation>,
         collectionViewLayout: CollectionViewCustomLayout,
         cellProvider: @escaping DataSource.CellProvider) {
        self.cellProvider = cellProvider
        self.collectionViewLayout = collectionViewLayout
        self.viewModel = viewModel
        self.snapshot = snapshot
    }
}

// MARK: UIViewRepresentable

extension CollectionView: UIViewRepresentable {
    //Creates the UICollectionView instance
    func makeUIView(context: Context) -> BaseCollectionView {
        collectionViewLayout.delegate = context.coordinator
        let collectionView = BaseCollectionView(frame: .zero,
                                                collectionViewLayout: collectionViewLayout,
                                                updateScrollPosition: viewModel.updateScrollPosition,
                                                cellProvider: cellProvider)
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    //Updates the UICollectionView with new data.
    func updateUIView(_ uiView: BaseCollectionView,
                      context: Context) {
        uiView.apply(snapshot, animatingDifferences: false)
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
    
    // MARK: - Coordinator
    final class Coordinator: NSObject,
                             CollectionViewCustomLayoutDelegate,
                             UICollectionViewDelegate {
        
        private var viewModel: CollectionViewModel
        init(viewModel: CollectionViewModel) {
            self.viewModel = viewModel
        }
        
        //Calculates the height for a photo cell at a specific index path.
        func collectionView(_ collectionView: UICollectionView,
                            heightForPhotoAtIndexPath indexPath: IndexPath,
                            cellWidth: CGFloat) -> CGFloat {
            let item = viewModel.photos[indexPath.row]
            
            guard let width = item.width,
                  let height = item.height else { return 0 }
            
            let aspectRatio = CGFloat(width) / CGFloat(height)
            
            return cellWidth / aspectRatio
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            viewModel.didItemSelectAt.send(indexPath)
        }
        
        //Detects when scrolling has ended to fetch more items if needed
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let offset = scrollView.contentOffset
            let bounds = scrollView.bounds
            let size = scrollView.contentSize
            
            let offsetY = offset.y + bounds.size.height
            let sizeHeight = size.height
            
            let reloadThreshold = CGFloat(30)
            if offsetY > sizeHeight + reloadThreshold {
                viewModel.fetchMoreGalleryItem.send()
                //TODO: Add loading state with a delay
            }
        }
    }
}
