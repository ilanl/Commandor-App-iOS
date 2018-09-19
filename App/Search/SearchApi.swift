import UIKit

class SearchApi {
  
    let processingQueue = OperationQueue()
    
    func searchCommandsForTerm(_ searchTerm: String, completion : @escaping (_ results: ActionSearchResults?, _ error : NSError?) -> Void){
        
        var data:[Action] = []
        let feedMetaData = FeedFetcher().getData()

        feedMetaData.forEach { (metaData) in
            guard let type = metaData["type"] as? String else { return }
            if searchTerm.contains(type) {
                data.append(Action(handler: RunSchemeHandler(id: "1", params: metaData)))
            }
        }
        
        let searchResults = ActionSearchResults(searchTerm: searchTerm, searchResults: data)

        OperationQueue.main.addOperation({
            completion(searchResults, nil)
        })
    }
}
