//
//  HomeProgramsViewController.swift
//  Postuparium
//
//  Created by Михаил on 26.12.2020.
//

import Foundation
import UIKit

class HomePrograms: UIView {
    
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
//        isExclusiveTouch = true
    }
}
