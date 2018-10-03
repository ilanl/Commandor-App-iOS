
import Commandor

class WidgetRepository {
    
    private (set) var map: [String:WidgetProtocol.Type] = [:]
    
    init() {
        
        let arrayOfPlugins = PluginLoader().getClassesByProtocol(p: Commandor.WidgetProtocol.self) as! [WidgetProtocol.Type]
        arrayOfPlugins.forEach { (t) in
            map[t.getSupportedDescriptor()] = t
        }
        print(map)
    }
}
