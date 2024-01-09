//
//  Coordinator.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import SwiftUI
import Combine

protocol Coordinator: ObservableObject {
    associatedtype view: View
    var path: NavigationPath { get set }
    
    func start() -> view
}

extension Coordinator {
    func push(_ page: Route) {
        path.append(page)
    }
}
