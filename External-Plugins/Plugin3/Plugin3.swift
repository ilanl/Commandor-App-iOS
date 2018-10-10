//
//  Plugin1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

public class Plugin3: WidgetProtocol {
    public var layout: WidgetViewLayout? {
        get {
            return WidgetViewLayout(isWide: true)
        }
    }
    
    public static func getSupportedDescriptor() -> String {
        return "handler3"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, WidgetError?) -> Void) {
        print("click3 \(address(o: self))")
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: View3?
    public func getView() -> UIView {
        
        guard self._view == nil else {
            return self._view!
        }
        
        self._view = View3.create()
        return self._view!
    }
}
