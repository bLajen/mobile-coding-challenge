//
//  ContentView.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = PhotoGalleryCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.start()
                .navigationDestination(for: Route.self) { coordinator in
                    coordinator.build()
                }
        }
        .environmentObject(coordinator) //gerekmiyorsa kaldir
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
