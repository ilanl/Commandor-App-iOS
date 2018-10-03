import Foundation
import Commandor

struct SearchResults {
    let searchTerm : String?
    let results : [WidgetProtocol]
    
    subscript(index: Int) -> WidgetProtocol {
        return results[index]
    }
    
    var count: Int {
        get {
            return results.count
        }
    }
    
}
