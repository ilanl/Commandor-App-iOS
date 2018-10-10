
import Commandor

public class CreateNoteWidget: WidgetProtocol {
    public var type: WidgetType {
        get { return .action }
    }
    
    public var layout: WidgetViewLayout? {
        get {
            return WidgetViewLayout(isWide: false)
        }
    }
    
    public static func getSupportedDescriptor() -> String {
        return "create-note"
    }
    
    public func onClick(window: UIWindow, completion: (UIWindow, WidgetError?) -> Void) {
        //
        print("click1 \(address(o: self))")
        
        if let url = URL(string:self.scheme) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        completion(window, nil)
    }
    
    private var id: String
    private var json: [String: Any]
    private var scheme: String
    
    public required init?(json: [String : Any]) {
        self.json = json
        self.id = self.json["id"] as! String
        self.scheme = self.json["scheme"] as! String
    }
    
    public func getIdentifier() -> String {
        return self.id
    }
    
    var _view: CreateNoteView?
    public func getView() -> UIView {
        guard self._view != nil else {
            return self._view!
        }
        
        self._view = CreateNoteView.create()
        return self._view!
    }
}
