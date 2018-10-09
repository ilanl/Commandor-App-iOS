//
//  ViewController.swift
//  App
//
//  Created by IlanL on 18/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit
import Commandor

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WidgetPinterestLayoutDelegate {
    
    func getPreferredLayout(for indexPath: IndexPath) -> PreferredLayout? {
        let widget = searchResults![indexPath.item]
        guard let layout = widget.layout else {
            return nil
        }
        return PreferredLayout(aspect: layout.aspect, isWide: layout.isWide)
    }
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "WidgetCell"
    
    //MARK: UICollectionView Events
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WidgetCell
        cell.handler.onClick(window: collectionView.window!) { (window, error) in
            print("back to main")
        }
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WidgetCell
        
        let widget = searchResults![indexPath.item]
        let contentView = widget.getView(superView: cell)
        
        // TODO: check adding with constraints and instrinsinc size
        cell.contentView.addSubview(contentView)
        cell.handler = widget
        
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
            
            let layout = WidgetPinterestLayout()
            layout.delegate = wSelf
            
            wSelf.searchResults = results
            wSelf.collectionView.collectionViewLayout = layout
            wSelf.collectionView.dataSource = self
            wSelf.collectionView.invalidateIntrinsicContentSize()
            
            wSelf.collectionView.reloadData()
            
        })
    }
}

