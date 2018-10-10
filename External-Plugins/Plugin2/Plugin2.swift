//
//  Plugin1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

public class Plugin2: WidgetProtocol {
    public var layout: WidgetViewLayout? {
        get {
            let wide = (self.json["wide"] as? Bool) == true
            let aspect: CGFloat = 1
            return WidgetViewLayout(aspect: aspect, isWide: wide)
        }
    }
    
    public static func getSupportedDescriptor() -> String {
        return "handler2"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, WidgetError?) -> Void) {
        print("click2 \(address(o: self))")
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    private var lines: Int
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
        self.lines = self.json["lines"] as! Int
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: View2?
    public func getView() -> UIView {
        
        guard self._view == nil else {
            return self._view!
        }
        
        self._view = View2.create()
        self._view?.label.text = "\(self.id)\(randomText(numOfLines: self.lines))"
        return self._view!
    }
}
