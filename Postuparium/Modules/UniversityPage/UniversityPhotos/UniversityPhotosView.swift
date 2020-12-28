//
//  UniversityPhotoView.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

class UniversityPhotos: UIView {
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
