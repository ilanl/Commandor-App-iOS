//
//  PreferenceDefaultsReader.swift
//
//  Created by IlanL on 19/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

/// If no url is given fallback to default feed from disk
class WidgetSync {
    
    func getData(url: URL? = nil) -> [[String: Any]] {
        
        var results: [[String: Any]] = []
        if let url = Bundle.main.url(forResource: "feed", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let jsonResult = jsonResult as? [[String: Any]] {
                    results.append(contentsOf: jsonResult)
                }
            } catch {
                print("error:\(error)")
            }
        }
        return results
    }
}
