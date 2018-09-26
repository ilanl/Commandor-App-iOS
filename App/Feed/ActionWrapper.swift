import Commandor

class ActionWrapper: Equatable {
    
    var handler: CommandActionProtocol!
    init (handler:CommandActionProtocol) {
        self.handler = handler
    }
}

func == (lhs: ActionWrapper, rhs: ActionWrapper) -> Bool {
  return lhs.handler.getIdentifier() == rhs.handler.getIdentifier()
}
