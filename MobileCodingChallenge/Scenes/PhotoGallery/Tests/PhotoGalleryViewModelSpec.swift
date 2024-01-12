//
//  PhotoGalleryViewModelSpec.swift
//  MobileCodingChallengeTests
//
//  Created by Batuhan Ballı on 2024-01-11.
//

@testable import MobileCodingChallenge
import XCTest

class PhotoGalleryViewModelSpec: XCTestCase {
    var viewModel: PhotoGalleryViewModel!
    
    override func setUp() {
        viewModel = PhotoGalleryViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testUpdateDataSource() {
        let photo = loadPhotosJson(filename: "photo_response")
        viewModel.updateDataSource(models: photo ?? [])
        
        let snapshotItemCount = viewModel.snapshot.numberOfItems(inSection: 0)
        
        XCTAssertEqual(photo?.count, viewModel.photos.count)
        XCTAssertEqual(photo?.count, snapshotItemCount)
        XCTAssertEqual(viewModel.photos.count, snapshotItemCount)
    }
}

extension PhotoGalleryViewModelSpec {
    private func loadPhotosJson(filename fileName: String) -> [PhotoResponse]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PhotoResponse.self, from: data)
                return [jsonData]
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
