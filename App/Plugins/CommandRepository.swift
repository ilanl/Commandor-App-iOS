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
        let mapOfPlugins = PluginLoader().getClassesByProtocol(p: Commandor.HandlerProtocol.self)
        print(mapOfPlugins)
    }
    
    
}
