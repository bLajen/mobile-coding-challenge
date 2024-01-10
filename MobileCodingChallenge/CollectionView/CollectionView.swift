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
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>
    
    @Binding private var photos: [PhotoResponse]
    
    private let cellProvider: DataSource.CellProvider
    private let snapshot: Snapshot
    
    init(snapshot: Snapshot,
         photos: Binding<[PhotoResponse]>,
         cellProvider: @escaping DataSource.CellProvider) {
        self._photos = photos
        self.snapshot = snapshot
        self.cellProvider = cellProvider
    }
    
}
