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
    
    @Binding private var photos: [PhotoResponse]
    @Binding private var orientation: UIDeviceOrientation
    
    private let cellProvider: DataSource.CellProvider
    private let snapshot: Snapshot
    private let collectionViewLayout: CollectionViewCustomLayout
    
    init(snapshot: Snapshot,
         photos: Binding<[PhotoResponse]>,
         orientation: Binding<UIDeviceOrientation>,
         collectionViewLayout: CollectionViewCustomLayout,
         cellProvider: @escaping DataSource.CellProvider) {
        self._photos = photos
        self._orientation = orientation
        
        self.snapshot = snapshot
        self.cellProvider = cellProvider
        self.collectionViewLayout = collectionViewLayout
    }
}

// MARK: UIViewRepresentable

extension CollectionView: UIViewRepresentable {
    func makeUIView(context: Context) -> BaseCollectionView {
        collectionViewLayout.delegate = context.coordinator
        let collectionView = BaseCollectionView(frame: .zero,
                                                collectionViewLayout: collectionViewLayout,
                                                cellProvider: cellProvider)
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    func updateUIView(_ uiView: BaseCollectionView,
                      context: Context) {
        uiView.apply(snapshot,
                     animatingDifferences: false)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(photos: $photos)
    }
    
    final class Coordinator: NSObject,
                             CollectionViewCustomLayoutDelegate,
                             UICollectionViewDelegate {
        @Binding private var photos: [PhotoResponse]
        
        init(photos: Binding<[PhotoResponse]>) {
            self._photos = photos
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            heightForPhotoAtIndexPath indexPath: IndexPath,
                            cellWidth: CGFloat) -> CGFloat {
            let item = photos[indexPath.row]
            
            guard let width = item.width,
                  let height = item.height else { return 0 }
            
            let aspectRatio = CGFloat(width) / CGFloat(height)
            
            return cellWidth / aspectRatio
        }
    }
}
