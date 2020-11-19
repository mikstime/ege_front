//
//  ProgramsSelectionItem.swift
//  Postuparium
//
//  Created by Михаил on 15.11.2020.
//

import UIKit

@IBDesignable
class ProgramsSelectionItem: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    @IBInspectable var text: String {

     get{
        return label?.text ?? ""
      }
      set {
        label?.text = newValue
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
