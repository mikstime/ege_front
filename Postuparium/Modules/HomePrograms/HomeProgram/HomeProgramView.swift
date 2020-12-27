//
//  HomeProgram.swift
//  Postuparium
//
//  Created by Михаил on 27.12.2020.
//

import Foundation
import UIKit

@IBDesignable
class HomeProgramView: UIView {
    
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var universityNameView: UILabel!
    @IBOutlet weak var programNameView: UILabel!
    @IBOutlet weak var probabilityView:UILabel!
    @IBOutlet weak var universityLogo: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var probabilityColorView: UIView!
    var program: EdProgram! {
        didSet {
            universityNameView?.text = program.university
            programNameView?.text = program.name
            setImage(from: program.photo)
//            setImage(from: "https://image.blockbusterbd.net/00416_main_image_04072019225805.png")
            probabilityView?.text = program.probability
            updateGradient()
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
        self.layer.masksToBounds = false
        setupGradient()
//        isExclusiveTouch = true
        
        probabilityColorView?.layer.cornerRadius = 15
        probabilityColorView?.layer.maskedCorners = [.layerMaxXMinYCorner]
        
    }
    
    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
            shadowLayer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOpacity = 0.16
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowRadius = 6
            layer.insertSublayer(shadowLayer, at: 0)
            setupGradient()
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.universityLogo?.image = image
            }
        }
    }
    
    var gradient: CAGradientLayer!
    var grayGradient: CAGradientLayer!
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        updateGradient()
        updateGrayGradient()
    }
    
    func setupGradient() {
        gradient = CAGradientLayer()
        gradient.maskedCorners = [.layerMaxXMinYCorner]
        gradient.cornerRadius = 15
        gradient.frame.size = frame.size
        gradient.startPoint = .init(x: 0.5, y: 0)
        gradient.endPoint   = .init(x: 0.5, y: 1)
        gradient.locations = [0.0, 1.0]
        probabilityColorView.layer.insertSublayer(gradient, at: 0)
        updateGradient()
        
        grayGradient = CAGradientLayer()
        grayGradient.frame.size = frame.size
        grayGradient.startPoint = .init(x: 0.5, y: 0)
        grayGradient.endPoint   = .init(x: 0.5, y: 1)
        grayGradient.locations = [0.0, 1.0]
        backgroundView.layer.insertSublayer(grayGradient, at: 0)
        updateGrayGradient()
    }
    
    func updateGrayGradient() {
        grayGradient.colors = [UIColor(named: "GrayGradientTop")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, UIColor(named: "GrayGradientBottom")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor]
    }
    
    func updateGradient() {
        guard let program = program else {
            gradient.colors = [UIColor(named: "homeProgramLowTop")?.cgColor ?? #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, UIColor(named: "homeProgramLowBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]
            return;
        }
        let prob = program.probablilityNumber
        if prob < 0.33 {
            gradient.colors = [UIColor(named: "homeProgramLowTop")?.cgColor ?? #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor, UIColor(named: "homeProgramLowBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]
        } else if prob < 0.66 {
            gradient.colors = [UIColor(named: "homeProgramMediumTop")?.cgColor ?? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0.87).cgColor, UIColor(named: "homeProgramMediumBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]
        } else {
            gradient.colors = [UIColor(named: "homeProgramHighTop")?.cgColor ?? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0.87).cgColor, UIColor(named: "homeProgramHighBottom")?.cgColor ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor]
        }
    }
}
