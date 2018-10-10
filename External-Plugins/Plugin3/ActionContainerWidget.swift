
import Commandor

public class ActionContainerWidget: WidgetProtocol {
    
    public var type: WidgetType {
        get { return .placeholder }
    }
    
    public var layout: WidgetViewLayout? {
        get {
            return WidgetViewLayout(isWide: true)
        }
    }
    
    public static func getSupportedDescriptor() -> String {
        return "action-container"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, WidgetError?) -> Void) {
        print("click3 \(address(o: self))")
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: ActionContainerView?
    public func getView() -> UIView {
        
        guard self._view == nil else {
            return self._view!
        }
        
        self._view = ActionContainerView.create()
        return self._view!
    }
}
