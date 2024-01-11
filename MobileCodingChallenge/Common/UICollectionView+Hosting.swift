//
//  UICollectionView+hosting.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import SwiftUI
import UIKit

extension UICollectionView.CellRegistration {
    static func hosting<Content: View, Item>(
        content: @escaping (IndexPath, Item) -> Content) -> UICollectionView.CellRegistration<UICollectionViewCell, Item> {
            
            UICollectionView.CellRegistration { cell, indexPath, item in
                cell.contentConfiguration = UIHostingConfiguration {
                    content(indexPath, item)
                }
            }
        }
}
