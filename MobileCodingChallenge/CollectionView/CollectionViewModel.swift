//
//  CollectionViewModel.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-14.
//

import Combine
import SwiftUI

final class CollectionViewModel: ObservableObject {
    @Published var photos: [PhotoResponse] = []
    
    //Subjects
    let updateScrollPosition: PassthroughSubject<Int, Never>
    let didItemSelectAt = PassthroughSubject<IndexPath, Never>()
    let fetchMoreGalleryItem = PassthroughSubject<Void, Never>()
    
    init(updateScrollPosition: PassthroughSubject<Int, Never> = PassthroughSubject<Int, Never>()) {
        self.updateScrollPosition = updateScrollPosition
    }
    
    //Update the data source with new model
    func updateDataSource(models: [PhotoResponse]) {
        photos.append(contentsOf: models)
    }
}
