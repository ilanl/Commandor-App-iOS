//
//  ViewController.swift
//  App
//
//  Created by IlanL on 18/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit
import Commandor

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CustomLayoutDelegate {
    
    //MARK: CustomLayoutDelegate
    public func getPreferredHeightForView(indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let handler = searchResults!.searchResults[indexPath.item].handler
        let aspect = handler!.layout.aspect
        return width * aspect
    }
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "HandlerCell"
    
    //MARK: UICollectionView Events
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HandlerCell
        cell.handler.onClick(window: collectionView.window!) { (window, error) in
            print("back to main")
        }
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults!.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HandlerCell
        
        let handler = searchResults!.searchResults[indexPath.item].handler
        let contentView = handler!.getView(superView: cell)
        
        cell.contentView.addSubview(contentView)
        cell.handler = handler
        
        return cell
    }
    
    var searchResults: SearchResults?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        self.collectionView.delegate = self
        
        SearchApi().query(nil, completion: { [weak self] (results, error) in
            guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
            }
            
            guard let wSelf = self else { return }
            
            let layout = CustomLayout()
            layout.delegate = wSelf
            
            wSelf.searchResults = results
            wSelf.collectionView.collectionViewLayout = layout
            wSelf.collectionView.dataSource = self
            wSelf.collectionView.invalidateIntrinsicContentSize()
            
            wSelf.collectionView.reloadData()
            
        })
    }
}

