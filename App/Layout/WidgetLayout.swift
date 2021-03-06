// TODO: Add credits to Git ... Ray Wenderlich Pinterest Layout Article
import UIKit

protocol WidgetFlowLayoutDelegate: class {
    
    func getFittedLayout(for indexPath: IndexPath, width: CGFloat) -> ItemLayout
}

extension MainWidgetViewController: WidgetFlowLayoutDelegate {
    
    //    TODO: add doc
    func getFittedLayout(for indexPath: IndexPath, width: CGFloat) -> ItemLayout {
        
        var cachedLayout = self.sections[indexPath.section].itemData[indexPath.row].layout
        if cachedLayout != nil, cachedLayout!.size != .zero {
            return cachedLayout!
        }
        
        let item = self.sections[indexPath.section].itemData[indexPath.row]
        let widget = item.handler
        let contentView = widget!.getView()
        let sz = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        // proportions
        var height = ceil(width*sz.height/sz.width)
        
        if (widget!.layout!.isWide) {
            height = contentView.frame.height * 1.1
        }
        
        cachedLayout = ItemLayout(size: CGSize(width: width, height: height), isWide: widget!.layout!.isWide)
        self.sections[indexPath.section].itemData[indexPath.row].layout = cachedLayout
        print("[Debug Size] [\(indexPath.section),\(indexPath.row)] -> \(String(describing: cachedLayout))")
        return cachedLayout!
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
    
    fileprivate var deleteIndexPaths = [IndexPath]()
    fileprivate var insertIndexPath = [IndexPath]()
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    func resetAllCache() {
        self.cache.removeAll()
        self.column = 0
        self.yOffset = [CGFloat]()
        self.maxColumnY = [CGFloat]()
        self.xOffset = [CGFloat]()
        self.columnWidth = 0
        self.preparedItems.removeAll()
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    func prepareItem(indexPath: IndexPath) {
        
        // 4. Asks the delegate for the height of the view for the given column width
        let preferredLayout = delegate.getFittedLayout(for: indexPath, width: columnWidth)
        let minHeight = preferredLayout.size.height
        
        let height = cellPadding * 2 + minHeight
        var width = columnWidth
        
        if preferredLayout.isWide {
             width = self.collectionView!.frame.width - self.collectionView!.contentInset.left - self.collectionView!.contentInset.right
        }
        
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        
        // 6. Updates the collection view content height
        contentHeight = max(contentHeight, frame.maxY)
        
        let newColumY = yOffset[column] + height
        
        yOffset[column] = newColumY
        
        if (preferredLayout.isWide) {
            for (index, _) in yOffset.enumerated() {
                yOffset[index] = newColumY
            }
        }
        
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
    
    // MARK: Animation: Insert/Delete
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        self.deleteIndexPaths = []
        self.insertIndexPath = []
        
        updateItems.forEach { (updateItem) in
            let action = updateItem.updateAction
            
            switch(action) {
            case .delete:
                self.deleteIndexPaths.append(updateItem.indexPathBeforeUpdate!)
                return
            case .insert:
                self.insertIndexPath.append(updateItem.indexPathAfterUpdate!)
                return
            default:
                return
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        self.deleteIndexPaths = []
        self.insertIndexPath = []
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        if self.insertIndexPath.contains(itemIndexPath) {
            if (attributes == nil) {
                attributes = self.layoutAttributesForItem(at: itemIndexPath)
            }
            
            attributes?.alpha = 0
            // TODO: change this
//            attributes?.center = self.collectionView!.center
        }
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        if deleteIndexPaths.contains(itemIndexPath) {
            if (attributes == nil) {
                attributes = self.layoutAttributesForItem(at: itemIndexPath)
            }
            attributes!.alpha = 0
//            attributes!.center = collectionView!.center
            attributes!.transform3D = CATransform3DMakeScale(0.1, 0.1, 0.1)
        }
        return attributes
    }
}
