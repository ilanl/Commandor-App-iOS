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
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: UIView?
    public func getView(superView: UIView) -> UIView {
        
        if _view == nil {
            let frame = superView.bounds
            _view = View2(frame: frame)
        }
        return _view!
    }
}
