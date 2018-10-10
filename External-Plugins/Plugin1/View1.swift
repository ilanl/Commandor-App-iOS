//
//  View1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

class View1: UIView {
    class func create() -> View1 {
        let myClassNib = UINib(nibName: "View1", bundle: nil)
        let view = myClassNib.instantiate(withOwner: nil, options: nil)[0] as! View1
        return view
    }
}
