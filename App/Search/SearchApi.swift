import UIKit

class SearchApi {
  
    let processingQueue = OperationQueue()
    
    func searchCommandsForTerm(_ searchTerm: String, completion : @escaping (_ results: SearchResults?, _ error : NSError?) -> Void){
        
        var data:[ActionWrapper] = []
        let feedMetaData = FeedFetcher().getData()

        feedMetaData.forEach { (metaData) in
            guard let type = metaData["type"] as? String else { return }
            if searchTerm.contains(type) {
                //data.append(Action(handler: RunSchemeHandler(id: "1", params: metaData)))
            }
        }
        
        let searchResults = SearchResults(searchTerm: searchTerm, searchResults: data)

        OperationQueue.main.addOperation({
            completion(searchResults, nil)
        })
    }
}
