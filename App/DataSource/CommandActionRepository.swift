//
//  CommandRepository.swift
//  App
//
//  Created by IlanL on 21/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

class CommandActionRepository {
    
    private (set) var map: [String:WidgetProtocol.Type] = [:]
    
    init() {
        
        let arrayOfPlugins = PluginLoader().getClassesByProtocol(p: Commandor.WidgetProtocol.self) as! [WidgetProtocol.Type]
        arrayOfPlugins.forEach { (t) in
            map[t.getSupportedDescriptor()] = t
        }
        print(map)
    }
}
