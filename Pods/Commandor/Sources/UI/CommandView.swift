//
//  UIHandlerView.swift
//  Pod
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import UIKit

open class CommandView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    final func setup() {
        fromNib()
    }
}
