// TODO: Add credits to Git ... Ray Wenderlich Pinterest Layout Article
import UIKit

protocol WidgetFlowLayoutDelegate: class {
    
    func getFittedSizeFor(for indexPath: IndexPath, width: CGFloat) -> CGSize?
}

extension MainWidgetViewController: WidgetFlowLayoutDelegate {
    //    TODO: add doc
    func getFittedSizeFor(for indexPath: IndexPath, width: CGFloat) -> CGSize? {
        
        let cachedSize = self.sections[indexPath.section].itemData[indexPath.row].size
        if cachedSize != .zero {
            return cachedSize
        }
        
        let item = self.sections[indexPath.section].itemData[indexPath.row]
        let widget = item.handler
        let contentView = widget!.getView()
        let sz = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        let height = ceil(width*sz.height/sz.width)
        let fitSize = CGSize(width: width, height: height)
        self.sections[indexPath.section].itemData[indexPath.row].size = fitSize
        print("[Debug Size] [\(indexPath.section),\(indexPath.row)] -> \(fitSize)")
        return fitSize
    }
}

class WidgetLayout: UICollectionViewLayout {
    
    //1. Pinterest Layout Delegate
    weak var delegate: WidgetFlowLayoutDelegate!
    
    //2. Configurable properties
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    //3. Array to keep a cache of attributes.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //4. Content height and size
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var column = 0
    fileprivate var yOffset = [CGFloat]()
    fileprivate var maxColumnY = [CGFloat]()
    fileprivate var xOffset = [CGFloat]()
    fileprivate var columnWidth: CGFloat = 0
    fileprivate var preparedItems = [IndexPath]()
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    func prepareItem(indexPath: IndexPath) {
        
        // 4. Asks the delegate for the height of the view for the given column width
        let minHeight = delegate.getFittedSizeFor(for: indexPath, width: columnWidth)!.height
        let height = cellPadding * 2 + minHeight
        
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6. Updates the collection view content height
        contentHeight = max(contentHeight, frame.maxY)
        
        let newColumY = yOffset[column] + height
        yOffset[column] = newColumY
        
        print("Debug Y [\(indexPath.section),\(indexPath.row)] -> \(newColumY)")
        
        var minY = Int.max
        var position = 0
        for (index,value) in yOffset.enumerated() {
            let intValue: Int = Int(value)
            if intValue < minY {
                minY = intValue
                position = index
            }
        }
        
        // 7. Electing the next best position for compact layout
        self.column = position
        preparedItems.append(indexPath)
    }
    
    override func prepare() {
        
        // 1. Only calculate once
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        yOffset = [CGFloat](repeating: 0, count: self.numberOfColumns)
        maxColumnY = [CGFloat](repeating: 0, count: self.numberOfColumns)
        
        // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        columnWidth = contentWidth / CGFloat(numberOfColumns)
        for c in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(c) * columnWidth)
        }
        
        // 3. Iterates through the list of items in the first section
        let section = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: section) {
            prepareItem(indexPath: IndexPath(item: item, section: section))
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if (!preparedItems.contains(indexPath)){
            prepareItem(indexPath: indexPath)
        }
        return cache[indexPath.item]
}

}
