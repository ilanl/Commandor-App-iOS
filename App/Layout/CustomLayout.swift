//
//  CustomLayout.swift
//  App
//
//  Created by IlanL on 01/10/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    
    // MARK: Public API
    weak var delegate: CustomLayoutDelegate?
    var numberOfColumns = 2
    var cellPadding: CGFloat = 3
    
    // MARK: Layout
    private var cache = [CustomMultipleColumnLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            guard let collectionView = collectionView else {
                fatalError()
            }
            let insets = collectionView.contentInset
            let width = collectionView.bounds.width
            return width - (insets.left + insets.right)
        }
    }
    
    convenience init(cellPadding: CGFloat, numberOfColumns: Int) {
        self.init()
        self.cellPadding = cellPadding
        self.numberOfColumns = numberOfColumns
    }
    
    // MARK: Public API
    func clearCache() {
        cache.removeAll()
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = CustomMultipleColumnLayoutAttributes(forCellWith: indexPath)
        let frame = CGRect(x: -231, y: -231, width: 1, height: 1).insetBy(dx: cellPadding, dy: cellPadding)
        attributes.frame = frame
        return attributes
    }
    
    override func prepare() {
        if cache.isEmpty {
            guard let collectionView = collectionView else {
                return
            }
            let columnWidth = width / CGFloat(numberOfColumns)
            
            // Create arrays to hold x and y offsets of each
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append((CGFloat(column) * columnWidth))
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
//                let width = columnWidth - (cellPadding * 2)
                
                // Calculate height
                let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? CGFloat(integerLiteral: Int.random(in: 50 ..< 100))
                
                let annotationHeight = delegate?.collectionView(collectionView, heightForAnnotationAtIndexPath: indexPath) ?? CGFloat(integerLiteral: Int.random(in: 50 ..< 100))
                
                let height: CGFloat = cellPadding + photoHeight + annotationHeight + cellPadding
                
                let frame = CGRect(x: xOffsets[column],
                       y: yOffsets[column],
                       width: columnWidth,
                       height: height).insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = CustomMultipleColumnLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                attributes.photoHeight = photoHeight
                attributes.annotationHeight = annotationHeight
                
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }
}


