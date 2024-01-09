//
//  Route.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import SwiftUI

enum Route {
    case gallery
    
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .gallery:
            PhotoGalleryCoordinator().start()
        }
    }
}
