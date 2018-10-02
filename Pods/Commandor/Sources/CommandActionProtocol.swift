//
//  HandlerProtocol.swift
//
//  Created by IlanL on 13/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

//MARK: Public Protocol
@objc public protocol CommandActionProtocol: class {
    
    /// A constructor to create instance by class name
    init?(json: [String: Any])
    
    /// Get the supported command descriptor
    @objc static func getSupportedDescriptor() -> String
    
    /// Run the command
    ///
    /// - Parameters:
    ///   - window: if needed by the handler for example to show a screen and control the navigation
    ///   - callback: callback function, do what you need and close the screen after if needed
    @objc func onClick(window: UIWindow, completion: (UIWindow, CommandActionError?)-> Void)
    
    /// Getter for unique identifier
    func getIdentifier() -> String
    
    /// View factory
    func getView(superView: UIView) -> UIView
}
