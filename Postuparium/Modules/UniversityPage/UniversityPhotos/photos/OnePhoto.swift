//
//  UniversityPhotoView.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

class OnePhoto: UIView {
    @IBOutlet weak var fimageView: UIImageView!
    @IBOutlet weak var fContainer: UIView!
    @IBOutlet weak var sContainer: UIView!
    
    weak var dispatcher: UniversityPhotoDispatcher!
    
    @IBAction func onTap() {
        print("tap on photo")
        dispatcher?.didTapOnPhoto(photo: fimageView.image!)
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
    
    func setImage(from url: UIImage) {
        self.fimageView?.image = url
    }
}
