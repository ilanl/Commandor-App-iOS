//
//  ViewController.swift
//  App
//
//  Created by IlanL on 18/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

final class CommandsViewController: UIViewController {

//, UICollectionViewDelegate, UICollectionViewDataSource
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "CommandCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    //MARK: UICollectionViewDataSource
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell
//    }
//

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

