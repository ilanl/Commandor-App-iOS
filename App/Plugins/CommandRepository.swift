//
//  CommandRepository.swift
//  App
//
//  Created by IlanL on 21/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation
import Commandor

class CommandRepository {
    
    init() {
        
        var map: [String:HandlerProtocol.Type] = [:]
        let arrayOfPlugins = PluginLoader().getClassesByProtocol(p: Commandor.HandlerProtocol.self) as! [HandlerProtocol.Type]
        arrayOfPlugins.forEach { (t) in
            map[t.getSupportedDescriptor()] = t
        }
        print(map)
    }
    
    
}
