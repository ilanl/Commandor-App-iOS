//
//  PluginLoader.swift
//  App
//
//  Created by IlanL on 21/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

class PluginLoader {
    
    private func getClasses(filter: ((_ cls: AnyClass) -> Bool)) -> [AnyClass] {
        
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass>.allocate(capacity: Int(expectedClassCount))
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
        let actualClassCount:Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var classes = [AnyClass]()
        for i in 0 ..< actualClassCount {
            let currentClass: AnyClass = allClasses[Int(i)]
            if filter(currentClass) {
                print(NSStringFromClass(currentClass))
                classes.append(currentClass)
            }
            
        }
        
        allClasses.deallocate()
        
        return classes
    }
    
    func getClassesByProtocol(p: Protocol) -> [AnyClass] {
        return getClasses { (cls) -> Bool in
            return class_conformsToProtocol(cls, p)
        }
    }
}
