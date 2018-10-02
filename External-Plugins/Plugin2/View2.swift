//
//  View1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    for _ in 0..<length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    
    return randomString
}

class View2: CommandView {

    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let text = randomAlphaNumericString(length: Int.random(in: 1..<100))
        print(text)
        self.label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
