//
//  ProgramsSelectionMenu.swift
//  Postuparium
//
//  Created by Михаил on 15.11.2020.
//

import UIKit

@IBDesignable
class ProgramsSelectionMenu: UIView {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var sbSearchBar: UISearchBar!
    
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
        container.layer.cornerRadius = 20
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.16
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 6
        
        sbSearchBar.isTranslucent = false
        sbSearchBar.backgroundImage = UIImage()
        
        if let textfield = sbSearchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.borderWidth = 1
            textfield.cornerRadius = 10
            textfield.borderColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
        }
    }

}
