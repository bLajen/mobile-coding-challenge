//
//  CollectionViewCustomLayout.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-11.
//

import UIKit
import SwiftUI

protocol CollectionViewCustomLayoutDelegate: AnyObject {
    /// Delegate height calculation for collection view items.
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath,
                        cellWidth: CGFloat) -> CGFloat
}

class CollectionViewCustomLayout: UICollectionViewLayout {
    weak var delegate: CollectionViewCustomLayoutDelegate?
    
    @Binding private var orientation: UIDeviceOrientation
    
    //Configuration properties
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var numberOfColumns = 2
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    init(orientation: Binding<UIDeviceOrientation>) {
        self._orientation = orientation
        
        super.init()
    }
    
    required init?(coder decoder: NSCoder) {
        self._orientation = Binding<UIDeviceOrientation>.constant(.portrait)
        
        super.init(coder: decoder)
    }
    //Layout calculating attributes for each item
    override func prepare() {
        guard let collectionView = collectionView,
              collectionView.numberOfSections > 0 else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoHeight = delegate?.collectionView(collectionView,
                                                       heightForPhotoAtIndexPath: indexPath,
                                                       cellWidth: columnWidth) ?? 180
            
            let height = photoHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            //Update content height and yOffset for next item
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
