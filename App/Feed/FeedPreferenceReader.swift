//
//  FeedPreferenceReader.swift
//
//  Created by IlanL on 19/09/2018.
//  Copyright © 2018 IlanL Ltd. All rights reserved.
//

import Foundation

class FeedPreferenceReader {
    
    func getHandlerPreferences() -> [String:[HandlerJson]]? {
        
        guard let url = Bundle.main.url(forResource: "preferences", withExtension: "json") else {
            return nil
        }
        
        do {
            
            let data = try Data(contentsOf: url)
            guard let handlersByType = try? JSONDecoder().decode([String:[HandlerJson]].self, from: data) else {
                print("Error: Couldn't decode data into Feed")
                return nil
            }
            return handlersByType
        
        } catch {
            return nil
        }
    }
}
