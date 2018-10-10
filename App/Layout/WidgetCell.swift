//
//  HandlerCell.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit
import Commandor

class WidgetCell: UICollectionViewCell {
    var handler: WidgetProtocol!
    var margin: CGFloat { get{ return 4 } }
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
}
