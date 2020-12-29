//
//  StudyTileMediumCell.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import UIKit

class StudyTileMediumCell: UICollectionViewCell {

    @IBOutlet weak var codeNameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeContainer: UIView!
    var program: EdProgram = EdProgram() {
        didSet {
            codeLabel.text = program.code
            nameLabel.text = program.name
            codeNameLabel.text = String(program.name.first ?? "Э") + String(program.code[1] )
            typeLabel.text = "Бакалавр"
            self.nameLabel.fitTextToBounds()
//            self.typeContainer.layer.sublayers?.first?.removeFromSuperlayer()
            setGradientBackgroundColor()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.fitTextToBounds()
        
        
        self.typeContainer.roundCorners([.topRight, .bottomRight, .bottomLeft], radius: 15)
        self.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 15)
        
//        setGradientBackgroundColor()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        self.typeContainer.layer.sublayers?.first?.removeFromSuperlayer()
        setGradientBackgroundColor()
    }
    
    func cellRandomBackgroundColors() -> [UIColor] {
        let prob = program.probablilityNumber
        if prob < 0.33 {
            return [UIColor(named: "homeProgramLowTop") ?? #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1), UIColor(named: "homeProgramLowBottom") ?? #colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        } else if prob < 0.66 {
            return [UIColor(named: "homeProgramMediumTop") ?? #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), UIColor(named: "homeProgramMediumBottom") ?? #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)]
        } else {
            return [UIColor(named: "homeProgramHighTop") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), UIColor(named: "homeProgramHighBottom") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        }
    }
    func setGradientBackgroundColor() {
        let colors = cellRandomBackgroundColors()
        self.typeContainer.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
    }

}


