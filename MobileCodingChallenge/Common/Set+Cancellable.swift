//
//  Set+Cancellable.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import Combine

extension Set where Element == AnyCancellable {
    mutating func insert(_ elements: Cancellable?...) {
        insert(elements)
    }
    
    mutating func insert(_ elements: [Cancellable?]) {
        elements.forEach { $0?.store(in: &self) }
    }
}
