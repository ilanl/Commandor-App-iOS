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
    
    var title: String {
        get {
            return "Title"
        }
    }
    
    var view: UIView {
        get {
            var v :UIView
            v = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            v.backgroundColor = UIColor.red
            return v
        }
    }
    
    func canHandleCommand(name: String) -> Bool {
        return true
    }
    
    func doCommand(window: UIWindow, name: String, json: String, completion: (UIWindow, HandlerError?) -> Void) {
        completion(window, HandlerError(message: "bla"))
    }
}

public protocol HandlerProtocol: class {
    
    /// Check wether the handler support this command
    ///
    /// - Parameter name: command name, for example: play-media
    /// - Returns: true when supported, otherwise false
    func canHandleCommand(name: String) -> Bool
    
    /// Run the command
    ///
    /// - Parameters:
    ///   - window: if needed by the handler for example to show a screen and control the navigation
    ///   - name: command name
    ///   - json: json string
    ///   - callback: callback function, do what you need and close the screen after if needed
    
    func doCommand(window: UIWindow, name: String, json: String, completion: (UIWindow, HandlerError?)-> Void)
    
    /// Visual title
    var title: String { get }
    
    
    /// Basic visual control
    var view: UIView { get }
}
