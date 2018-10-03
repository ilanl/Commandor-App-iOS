import UIKit
import Commandor

class SearchApi {
  
    let processingQueue = OperationQueue()
    
    internal func query(_ searchTerm: String?, completion : @escaping (_ results: SearchResults?, _ error : NSError?) -> Void){
        
        guard let container = (UIApplication.shared.delegate as? AppContainerDelegate)?.container else { return }
        
        var arrayOfInstances:[WidgetProtocol] = []
        let feedMetaData = WidgetSync().getData()

        feedMetaData.forEach { (metaData) in
            guard let type = metaData["type"] as? String else { return }
            guard let handler = container.widgetRepository!.map[type]?.init(json: metaData) else { return }
            if searchTerm == nil || searchTerm!.contains(type) {
                arrayOfInstances.append(handler)
            }
        }
        
        let searchResults = SearchResults(searchTerm: searchTerm, results: arrayOfInstances)
        
        OperationQueue.main.addOperation({
            completion(searchResults, nil)
        })
    }
}
