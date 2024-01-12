//
//  PhotoGalleryCoordinatorSpec.swift
//  MobileCodingChallengeTests
//
//  Created by Batuhan Ballı on 2024-01-12.
//

@testable import MobileCodingChallenge
import XCTest

class PhotoGalleryCoordinatorSpec: XCTestCase {
    var coordinator: PhotoGalleryCoordinator!
    var viewModel: PhotoGalleryViewModel!
    
    override func setUp() {
        coordinator = PhotoGalleryCoordinator()
    }
    
    override func tearDown() {
        coordinator = nil
    }
    
    func testShowDetailView() {
        let firstState = coordinator.path.count
        coordinator.showDetailView(selectedImageIndex: 0)
        
        let secondState = coordinator.path.count
        
        XCTAssertTrue(coordinator.path.count > 0)
        XCTAssertTrue(secondState > firstState)
    }
    
    func testUpdateScrollPosition() throws {
        let firstState = 0
        coordinator.showDetailView(selectedImageIndex: 0)
        
        let secondState = try awaitPublisher(coordinator.imageIndexChanged) {
            self.coordinator.photoGalleryDetailViewModel.updateScrollPosition.send(1)
        }
        
        XCTAssertTrue(secondState > firstState)
    }
}
