//
//  CoreCollectionView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-10.
//

import SwiftUI
import Combine

final class CoreCollectionView<SectionType, ItemType>: UICollectionView
where SectionType: Hashable & Sendable,
      ItemType: Hashable & Sendable {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>
    
    private var cancellables = Set<AnyCancellable>()
    private let cellProvider: DataSource.CellProvider
    private let updateQueue: DispatchQueue = DispatchQueue(label: "updateCollection",
                                                           qos: .userInteractive)
    
    private lazy var collectionDataSource: DataSource = {
        DataSource(collectionView: self,
                   cellProvider: cellProvider)
    }()
    
    init(frame: CGRect,
         collectionViewLayout: UICollectionViewLayout,
         updateScrollPosition: PassthroughSubject<Int, Never>,
         cellProvider: @escaping DataSource.CellProvider) {
        
        self.cellProvider = cellProvider
        
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        
        cancellables.insert(
            updateScrollPosition.sink { [weak self] item in
                self?.scrollToItem(at: IndexPath(item: item, section: 0),
                                   at: .centeredVertically,
                                   animated: false)
            }
        )
        
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
