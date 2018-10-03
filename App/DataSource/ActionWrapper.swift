import Commandor

class ActionWrapper: Equatable {
    
    var handler: WidgetProtocol!
    init (handler:WidgetProtocol) {
        self.handler = handler
    }
}

func == (lhs: ActionWrapper, rhs: ActionWrapper) -> Bool {
  return lhs.handler.getIdentifier() == rhs.handler.getIdentifier()
}
