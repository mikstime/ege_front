//
//  StartScreenButton.swift
//  Postuparium
//
//  Created by Михаил on 16.11.2020.
//

import UIKit

@IBDesignable
class StartScreenButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    func _init() {
        
        let gradient = CAGradientLayer()

        gradient.frame.size = frame.size
        gradient.startPoint = .init(x: 1, y: 0)
        gradient.endPoint   = .init(x: 0, y: 1)
        gradient.locations = [0.0, 1.0]
        gradient.colors = [UIColor(named: "BlueGradientTop")?.cgColor ?? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0.87).cgColor, UIColor(named: "BlueGradientBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]

        layer.insertSublayer(gradient, at: 0)
        
        cornerRadius = 21
        setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        setTitle("Добавить", for: .normal)
        titleLabel?.font = titleLabel?.font.withSize(28)
    }
    
}
