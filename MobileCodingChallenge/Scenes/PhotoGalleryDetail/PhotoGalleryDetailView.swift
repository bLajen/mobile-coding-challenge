//
//  PhotoGalleryDetailView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import SwiftUI
import NukeUI

struct PhotoGalleryDetailView: View {
    @ObservedObject var viewModel: PhotoGalleryDetailViewModel
    
    var body: some View {
        ZStack {
            Color.secondary
                .ignoresSafeArea()
            TabView(selection: $viewModel.selectedImageIndex) {
                ForEach(0 ..< viewModel.photos.count, id: \.self) { index in
                    ZStack(alignment: .center) {
                        LazyImage(url: URL(string: viewModel.photos[index].urls?.regular ?? "")) { state in
                            if let image = state.image {
                                image.resizable().aspectRatio(contentMode: ContentMode.fit)
                            }
                        }
                        VStack {
                            Spacer() // Pushes the banner to the bottom
                            HStack {
                                Text(viewModel.photos[index].createdAt ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                Text(viewModel.photos[index].altDescription ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.8))
                            .edgesIgnoringSafeArea(.horizontal)
                        }
                    }
                    .background(.clear)
                    .shadow(radius: 20)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onRotate { newOrientation in
                viewModel.orientation = newOrientation
            }
        }
    }
}

