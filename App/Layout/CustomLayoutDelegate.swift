//
//  CustomLayoutDelegate.swift
//
//  Created by IlanL on 01/10/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

protocol CustomLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
    func collectionView(_ collectionView:UICollectionView, heightForAnnotationAtIndexPath indexPath:IndexPath) -> CGFloat
}
