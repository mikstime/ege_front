//
//  AchievementsItem.swift
//  Postuparium
//
//  Created by Михаил on 13.11.2020.
//

import UIKit

@IBDesignable
class AchievementsItem: UIView {
    
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var uiSwitch: UISwitch!
    
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
        container?.layer.borderWidth = 0
        container?.cornerRadius = 16
    }

}
