//
//  ProgramsSelectionItem.swift
//  Postuparium
//
//  Created by Михаил on 15.11.2020.
//

import UIKit

@IBDesignable
class ProgramsSelectionItem: UIView {
    weak var actionDispatcher: ProgramsSelectionItemDispatcherProtocol!
    
    @IBAction func TapRemoveButton() {
        actionDispatcher?.tappedRemoveProgram(programView: self)
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBInspectable var text: String {

        get{
            return label?.text ?? ""
        }
        set {
            label?.text = newValue
        }
    }
    var source: EdProgram = EdProgram() {
        
        didSet {
            text = source.name
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    func _init() {
        fromNib()
    }

}

protocol ProgramsSelectionItemDispatcherProtocol: class {
    func tappedRemoveProgram(programView: ProgramsSelectionItem!)
}
