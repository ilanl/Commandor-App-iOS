//
//  PreferenceDefaultsReader.swift
//
//  Created by IlanL on 19/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

/// If no url is given fallback to default feed from disk
class FeedFetcher {
    
    func getData(url: URL? = nil) -> [Dictionary<String, AnyObject>] {
        
        var results:[Dictionary<String, AnyObject>] = []
        if let url = Bundle.main.url(forResource: "feed", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let jsonResult = jsonResult as? [Dictionary<String, AnyObject>] {
                    results.append(contentsOf: jsonResult)
                }
            } catch {
                print("error:\(error)")
            }
        }
        return results
    }
}
