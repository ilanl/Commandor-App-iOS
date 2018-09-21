//
//  HandlerProtocol.swift
//
//  Created by IlanL on 13/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation
import UIKit

/// Tester class
public class PluginExampleHandler : HandlerProtocol {
    
    @objc public required init(id: String, params: Dictionary<String, AnyObject>?) {
        self.id = id
        self.params = params
    }
    
    @objc public static func isCompatible(with type: String) -> Bool {
        return type == "public-handler-type"
    }
    
    @objc public func onClick(window: UIWindow, completion: (UIWindow, HandlerError?) -> Void) {
        completion(window, HandlerError(message: "error"))
    }
    
    public private (set) var id: String
    
    public private (set) var params: Dictionary<String, AnyObject>?
    
    public var view: UIView {
        get {
            var v :UIView
            v = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            v.backgroundColor = UIColor.red
            return v
        }
    }
}

@objc public protocol HandlerProtocol: class {
    
    /// A constructor to create instance by class name
    @objc init(id: String, params: Dictionary<String, AnyObject>?)
    
    /// Check wether the handler support this type of command
    ///
    /// - Parameter name: command type, for example: play-media
    /// - Returns: true when supported, otherwise false
    @objc static func isCompatible(with type: String) -> Bool
    
    /// Run the command
    ///
    /// - Parameters:
    ///   - window: if needed by the handler for example to show a screen and control the navigation
    ///   - callback: callback function, do what you need and close the screen after if needed
    @objc func onClick(window: UIWindow, completion: (UIWindow, HandlerError?)-> Void)
    
    /// Identifier propery
    var id: String { get }
    
    /// Params propery (decoded from json)
    var params: Dictionary<String, AnyObject>? { get }
    
    /// Created view
    var view: UIView { get }
}
