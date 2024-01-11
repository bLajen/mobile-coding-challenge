//
//  Route.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import SwiftUI

enum Route {
    case gallery
    case detail(viewModel: PhotoGalleryDetailViewModel)
    
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .gallery:
            PhotoGalleryCoordinator().start()
        case let .detail(viewModel):
            PhotoGalleryDetailCoordinator(photoGalleryDetailViewModel: viewModel).start()
        }
    }
}

extension Route: Hashable, Identifiable {
    var id: Int { UUID().hashValue }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into myhasher: inout Hasher) {
        myhasher.combine(id)
    }
}
