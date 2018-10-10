//
//  Plugin1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

public class Plugin1: WidgetProtocol {
    public var layout: WidgetViewLayout? {
        get {
            let wide = (self.json["wide"] as? Bool) == true
            let aspect: CGFloat = CGFloat(Float.random(in: 0 ..< 1))
            return WidgetViewLayout(aspect: aspect, isWide: wide)
        }
    }
    
    
    public static func getSupportedDescriptor() -> String {
        return "handler1"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, WidgetError?) -> Void) {
        //
        print("click1 \(address(o: self))")
        
        if let url = URL(string:self.scheme) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    private var scheme: String
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
        self.scheme = self.json["scheme"] as! String
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: View1?
    public func getView() -> UIView {
        guard self._view != nil else {
            return self._view!
        }
        
        self._view = View1.create()
        return self._view!
    }
}
