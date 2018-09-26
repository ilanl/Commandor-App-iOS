//
//  Plugin1.swift
//  App
//
//  Created by IlanL on 26/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Commandor

public class Plugin1: CommandActionProtocol {
    
    public static func getSupportedDescriptor() -> String {
        return "handler1"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, CommandActionError?) -> Void) {
        //
        print("click1 \(address(o: self))")
        
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    
    public required init?(json: [String : Any]) {
        self.id = "11"
        self.json = json
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: UIView?
    public func getView(superView: UIView) -> UIView {
        
        if _view == nil {
            let frame = superView.bounds
            _view = View1(frame: frame)
        }
        return _view!
    }
}
