//
//  GalleryCell.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import SwiftUI
import NukeUI

struct GalleryCell: View {
    var viewModel: GalleryCellViewModel
    // TODO: Remove colors
    var body: some View {
        ZStack {
            Color.red
            LazyImage(url: URL(string: viewModel.item.urls?.regular ?? "")) { state in
                if let image = state.image {
                    image.resizable().aspectRatio(contentMode: ContentMode.fit)
                }
            }
        }
        .background(Color.gray)
    }
}
