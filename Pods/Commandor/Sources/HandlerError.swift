//
//  HandlerError.swift
//
//  Created by IlanL on 19/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

public class HandlerError: LocalizedError {
    
    var _desc: String
    public init(message: String) {
        _desc = message
    }
    public var errorDescription: String? {
        get{
            return _desc
        }
    }
}
