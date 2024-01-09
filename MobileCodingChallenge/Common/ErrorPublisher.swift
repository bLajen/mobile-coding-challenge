//
//  ErrorPublisher.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Combine

typealias ErrorPublisher<T> = AnyPublisher<T, Error>
