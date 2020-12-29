//
//  UniversityPhotoView.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

class TwoPhotos: UIView {
    
    @IBOutlet weak var fImage: UIImageView!
    @IBOutlet weak var sImage: UIImageView!
    
    @IBOutlet weak var fPhotoContainer: ShadowView!
    @IBOutlet weak var sPhotoContainer: ShadowView!
    
    weak var dispatcher: UniversityPhotoDispatcher!
    
    @IBAction func onTapOne() {
        dispatcher?.didTapOnPhoto(photo: fImage.image!)
    }
    
    @IBAction func onTapTwo() {
        dispatcher?.didTapOnPhoto(photo: sImage.image!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
        fPhotoContainer.alpha = 0
        sPhotoContainer.alpha = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }

    func _init() {
        fromNib()
    }
    
    func setFirstImage(from url: UIImage) {
        self.fImage?.image = url
        fPhotoContainer.alpha = 1.0
    }
    func setSecondImage(from url: UIImage) {
        self.sImage?.image = url
        sPhotoContainer.alpha = 1.0
    }
}
