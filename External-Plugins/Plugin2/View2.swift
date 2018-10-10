//
//  View1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

func randomText(numOfLines: Int) -> String {
    var text = ""
    for _ in 0..<numOfLines {
        text += "Hello Again!! \(numOfLines)\n"
    }
    
    return text
}

class View2: UIView {

    @IBOutlet weak var label: UILabel!
    
    class func create() -> View2 {
        let myClassNib = UINib(nibName: "View2", bundle: nil)
        let view = myClassNib.instantiate(withOwner: nil, options: nil)[0] as! View2
        return view
    }}
