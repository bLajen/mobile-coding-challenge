//
//  PhotoGalleryDetailViewModelSpec.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-12.
//

@testable import MobileCodingChallenge
import XCTest

class PhotoGalleryDetailViewModelSpec: XCTestCase {
    var viewModel: PhotoGalleryDetailViewModel!
    
    override func setUp() {
        viewModel = PhotoGalleryDetailViewModel(photos: [], selectedImageIndex: 0)
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testImageIndexChanged() throws {
        viewModel.selectedImageIndex = 0
        
        let selectedIndex = try awaitPublisher(viewModel.updateScrollPosition) {
            self.viewModel.imageIndexChanged(indexPath: 1)
        }
        
        XCTAssertTrue(selectedIndex == 1)
    }
}
