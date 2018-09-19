//
//  HandlerProtocol.swift
//
//  Created by IlanL on 13/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation
import UIKit

public protocol HandlerProtocol {
    
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
    
    func doCommand(window: UIWindow, name: String, json: String, completion: (UIWindow, NSError?)-> Void)
}
