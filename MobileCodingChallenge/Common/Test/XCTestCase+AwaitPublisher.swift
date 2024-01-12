//
//  XCTestCase+AwaitPublisher.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-12.
//

import Combine
import XCTest

extension XCTestCase {
    // Based on https://www.swiftbysundell.com/articles/unit-testing-combine-based-swift-code/
    func awaitPublisher<T: Publisher>(_ publisher: T,
                                      timeout: TimeInterval = 1,
                                      file: StaticString = #file,
                                      line: UInt = #line,
                                      hasInitialValue: Bool = false,
                                      triggers: (() -> Void)? = nil) throws -> T.Output {
        var result: Result<T.Output, Error>?
        
        let expectation = self.expectation(description: "Awaiting publisher")
        expectation.assertForOverFulfill = false
        
        let cancellable = publisher
            .dropFirst(hasInitialValue ? 1 : 0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    result = .failure(error)
                case .finished:
                    break
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                result = .success(value)
                expectation.fulfill()
            })
        
        triggers?()
        
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )
        
        return try unwrappedResult.get()
    }
}
