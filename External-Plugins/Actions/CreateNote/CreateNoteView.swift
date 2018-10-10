
import Commandor

class CreateNoteView: UIView {
    class func create() -> CreateNoteView {
        let myClassNib = UINib(nibName: "CreateNoteView", bundle: nil)
        let view = myClassNib.instantiate(withOwner: nil, options: nil)[0] as! CreateNoteView
        return view
    }
}
