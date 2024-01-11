//
//  CoreCollectionView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-10.
//

import SwiftUI

final class CoreCollectionView<SectionType, ItemType>: UICollectionView
where SectionType: Hashable & Sendable,
      ItemType: Hashable & Sendable {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>
    
    private let cellProvider: DataSource.CellProvider
    private let updateQueue: DispatchQueue = DispatchQueue(label: "updateCollection",
                                                           qos: .userInteractive)
    
    private lazy var collectionDataSource: DataSource = {
        DataSource(collectionView: self,
                   cellProvider: cellProvider)
    }()
    
    init(frame: CGRect,
         collectionViewLayout: UICollectionViewLayout,
         cellProvider: @escaping DataSource.CellProvider) {
        
        self.cellProvider = cellProvider
        
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(_ snapshot: Snapshot,
               animatingDifferences: Bool) {
        
        updateQueue.async { [weak self] in
            self?.collectionDataSource.apply(snapshot,
                                             animatingDifferences: animatingDifferences,
                                             completion: nil)
        }
    }
}
