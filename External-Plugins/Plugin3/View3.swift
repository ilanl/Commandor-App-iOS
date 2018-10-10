import Commandor

class View3: UIView {
        
    class func create() -> View3 {
        let myClassNib = UINib(nibName: "View3", bundle: nil)
        let view = myClassNib.instantiate(withOwner: nil, options: nil)[0] as! View3
        return view
    }}
