import Commandor

class View3: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var items: [String] = ["1", "2", "3", "5"]
    
    class func create() -> View3 {
        let myClassNib = UINib(nibName: "View3", bundle: nil)
        let view = myClassNib.instantiate(withOwner: nil, options: nil)[0] as! View3
        
        view.collectionView.dataSource = view
        
        let cellSize = CGSize(width: 100, height: 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        
        view.collectionView.setCollectionViewLayout(layout, animated: true)
        view.collectionView.register(UINib(nibName: "WidgetActionCell", bundle: nil), forCellWithReuseIdentifier: "WidgetActionCell")
        
        view.fetchData()
        return view
    }
}

extension View3 : UICollectionViewDataSource {
    
    func fetchData() {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WidgetActionCell", for: indexPath) as! WidgetActionCell
        
        cell.backgroundColor = UIColor.brown
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
}




