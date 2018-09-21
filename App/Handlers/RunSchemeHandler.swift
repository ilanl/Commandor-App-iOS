//
//  RunSchemeCommand.swift
//  App
//
//  Created by IlanL on 19/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation
import Commandor

class RunSchemeHandler: HandlerProtocol {
    
    required init(id: String, params: Dictionary<String, AnyObject>?) {
        self.id = id
        self.params = params
    }
    
    private static let type = "run-scheme"
    
    static func isCompatible(with type: String) -> Bool {
        return type == RunSchemeHandler.type
    }
    
    init(id: String, params: Dictionary<String, AnyObject>) {
        self.id = id
        self.params = params
    }
    
    func onClick(window: UIWindow, completion: (UIWindow, HandlerError?) -> Void) {
        completion(window, HandlerError(message: "bla"))
    }
    
    var id: String
    
    var params: Dictionary<String, AnyObject>?
    
    var view: UIView {
        get {
            var v :UIView
            v = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            v.backgroundColor = UIColor.red
            return v
        }
    }
}

