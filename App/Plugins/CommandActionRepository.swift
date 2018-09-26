//
//  CommandRepository.swift
//  App
//
//  Created by IlanL on 21/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

class CommandActionRepository {
    
    private (set) var map: [String:CommandActionProtocol.Type] = [:]
    
    init() {
        
        let arrayOfPlugins = PluginLoader().getClassesByProtocol(p: Commandor.CommandActionProtocol.self) as! [CommandActionProtocol.Type]
        arrayOfPlugins.forEach { (t) in
            map[t.getSupportedDescriptor()] = t
        }
        print(map)
    }
}
