//
//  ViewController.swift
//  App
//
//  Created by IlanL on 18/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit
import Commandor

class ViewController: UIViewController, UICollectionViewDataSource {
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "WrapperCell"
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appContainer!.commandRepository?.map.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WrapperCellView
        
        // TODO: order them somehow
        let pluginView = (appContainer!.commandRepository!.map["handler1"]!).init(json: [:])!.getView(superView: cell)
        
        cell.addSubview(pluginView)
        return cell
    }
    
    var appContainer: AppContainer?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.appContainer = (UIApplication.shared.delegate as! AppContainerDelegate).container
    }
    
    
}

