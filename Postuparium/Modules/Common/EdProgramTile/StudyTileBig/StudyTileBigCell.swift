//
//  StudyTileBigCell.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//


import UIKit

class StudyTileBigCell: UIView {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var codeNameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeContainer: UIView!
    var program: EdProgram = EdProgram()
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "StudyTileBigCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
        self.codeNameLabel.text = "?"
        
        self.codeLabel.text = "00.00.00"
        
        self.nameLabel.text = "Название направления"
        
//        self.nameLabel.fitTextToBounds()
        
        self.typeLabel.text = "Специальность"
        
        self.typeContainer.roundCorners([.topRight, .bottomRight, .bottomLeft], radius: 10)
        self.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 10)
        
    
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 5.0
        
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
