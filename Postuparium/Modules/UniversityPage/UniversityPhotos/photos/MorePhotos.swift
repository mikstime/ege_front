//
//  MorePhotos.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import Foundation
import UIKit

class MorePhotos: UIView {
    
    @IBOutlet weak var uImageView: UIImageView!
    @IBOutlet weak var uButton: UIButton!
    var gradient: CAGradientLayer!
    
    weak var dispatcher: UniversityPhotoDispatcher!
    
    @IBAction func onTapOne() {
        dispatcher?.didTapOnMore()
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
        setupGradient()
        setImage(from: UIImage())
    }
    
    func updateGradient() {
        gradient.colors = [UIColor(named: "BlueGradientTop")?.cgColor ?? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0.87).cgColor, UIColor(named: "BlueGradientBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]
    }
    
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        updateGradient()
    }
    
    func setupGradient() {
        self.uImageView.layer.masksToBounds = true
//        self.uImageView.roundCorners([.topLeft, .topRight], radius: 15)
        self.uImageView.cornerRadius = 15
        gradient = CAGradientLayer()
        uImageView.layer.insertSublayer(gradient, at: 0)
        gradient.frame.size = uImageView.frame.size
        gradient.startPoint = .init(x: 0.5, y: 0)
        gradient.endPoint = .init(x: 0.5, y: 1)
        gradient.locations = [0.0, 1.0]
        updateGradient()
    }
    
    func setImage(from url: UIImage) {
        self.uImageView?.image = url
    }
}
