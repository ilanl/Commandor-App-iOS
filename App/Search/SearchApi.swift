import UIKit

class SearchApi {
  
    let processingQueue = OperationQueue()
    
    internal func query(_ searchTerm: String?, completion : @escaping (_ results: SearchResults?, _ error : NSError?) -> Void){
        
        guard let container = (UIApplication.shared.delegate as? AppContainerDelegate)?.container else { return }
        
        var data:[ActionWrapper] = []
        let feedMetaData = FeedFetcher().getData()

        feedMetaData.forEach { (metaData) in
            guard let type = metaData["type"] as? String else { return }
            guard let handler = container.commandRepository!.map[type]?.init(json: [:]) else { return }
            if searchTerm == nil || searchTerm!.contains(type) {
                data.append(ActionWrapper(handler: handler))
            }
        }
        
        let searchResults = SearchResults(searchTerm: searchTerm, searchResults: data)
        
        OperationQueue.main.addOperation({
            completion(searchResults, nil)
        })
    }
}
