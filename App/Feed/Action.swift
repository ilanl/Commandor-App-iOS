import UIKit
import Commandor

class Action : Equatable {
    
    var handler: HandlerProtocol!
    init (handler:HandlerProtocol) {
        self.handler = handler
    }
}

func == (lhs: Action, rhs: Action) -> Bool {
  return lhs.handler.id == rhs.handler.id
}
