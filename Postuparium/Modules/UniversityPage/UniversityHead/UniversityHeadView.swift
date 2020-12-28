//
//  UniversityHead.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

class UniversityHead: UIView {
    var university: University? {
        didSet {
            setDetails()
            setImage()
        }
    }
    @IBOutlet weak var uImageView: UIImageView!
    @IBOutlet weak var uratingView: UILabel!
    @IBOutlet weak var uprogramsView: UILabel!
    @IBOutlet weak var unameLabel: UILabel!
    @IBOutlet weak var urankLabel:UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    var grayGradient: CAGradientLayer!
    
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
        setImage()
        setDetails()
        setupGradient()
    }
    
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        updateGrayGradient()
    }
    
    func updateGrayGradient() {
        grayGradient.colors = [UIColor(named: "GrayGradientTop")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, UIColor(named: "GrayGradientBottom")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor]
    }
    
    func setupGradient() {
        self.uImageView.layer.masksToBounds = true
        self.uImageView.roundCorners([.topLeft, .topRight], radius: 20)
        grayGradient = CAGradientLayer()
        grayGradient.frame.size = frame.size
        grayGradient.startPoint = .init(x: 0.5, y: 0)
        grayGradient.endPoint = .init(x: 0.5, y: 1)
        grayGradient.locations = [0.0, 1.0]
        uImageView.layer.insertSublayer(grayGradient, at: 0)
        updateGrayGradient()
    }
    
    func setImage() {
        let image = university?.image
        uImageView.image = image
        grayGradient?.frame.size = frame.size
        grayGradient?.startPoint = .init(x: 0.5, y: 0)
        grayGradient?.endPoint = .init(x: 0.5, y: 1)
        grayGradient?.locations = [0.0, 1.0]
    }
    
    func setDetails() {
        uratingView?.text = String(university?.rating ?? 0)
        uprogramsView?.text = String(university?.scores ?? 0)
        unameLabel?.text = String(university?.name ?? "")
        urankLabel?.text = String(university?.place ?? 0)
    }
}
