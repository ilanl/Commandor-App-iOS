//
//  AutoCollectionView.swift
//  App
//
//  Created by IlanL on 01/10/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

class AutoLayoutCollectionView: UICollectionView {
    
    private var shouldInvalidateLayout = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shouldInvalidateLayout {
            collectionViewLayout.invalidateLayout()
            shouldInvalidateLayout = false
        }
    }
    
    override func reloadData() {
        shouldInvalidateLayout = true
        super.reloadData()
    }
}

// TODO : extract to different extensions
