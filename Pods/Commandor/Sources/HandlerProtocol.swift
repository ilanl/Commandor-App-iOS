//
//  HandlerProtocol.swift
//
//  Created by IlanL on 13/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Tester class
private class PrivateHandler : HandlerProtocol {
    
    static func isCompatible(with type: String) -> Bool {
        return type == "private-type"
    }
    
    func onClick(window: UIWindow, completion: (UIWindow, HandlerError?) -> Void) {
        completion(window, HandlerError(message: "error"))
    }
    
    var id: String!
    
    var params: Dictionary<String, AnyObject>!
    
    var view: UIView {
        get {
            var v :UIView
            v = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            v.backgroundColor = UIColor.red
            return v
        }
    }
}

public protocol HandlerProtocol: class {
    
    /// Check wether the handler support this type of command
    ///
    /// - Parameter name: command type, for example: play-media
    /// - Returns: true when supported, otherwise false
    static func isCompatible(with type: String) -> Bool
    
    /// Run the command
    ///
    /// - Parameters:
    ///   - window: if needed by the handler for example to show a screen and control the navigation
    ///   - callback: callback function, do what you need and close the screen after if needed
    func onClick(window: UIWindow, completion: (UIWindow, HandlerError?)-> Void)
    
    /// Identifier propery
    var id: String! { set get }
    
    /// Params propery (decoded from json)
    var params: Dictionary<String, AnyObject>! { set get }
    
    /// Created view
    var view: UIView { get }
}
