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
    var program: EdProgram!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.codeNameLabel.text = "?"
//        self.codeLabel.text = "00.00.00"
//        self.nameLabel.text = "Название направления"
//        self.typeLabel.text = "Специальность"
    
        self.nameLabel.fitTextToBounds()
        
        
//        self.typeContainer.roundCorners([.topRight, .bottomRight, .bottomLeft], radius: 15)
        self.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 15)


      
//
        setGradientBackgroundColor()
//

        
//        self.shadowDecorate()
    }
    
    func cellRandomBackgroundColors() -> [UIColor] {
        //Colors
        let red = [#colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        let orangeRed = [#colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        let orange = [#colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 0.75)]
        let yellow = [#colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 0.75)]
        let green = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 0.75)]
        let greenBlue = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 0.75)]
        let kindaBlue = [#colorLiteral(red: 0.3796315193, green: 0.7958304286, blue: 0.2592983842, alpha: 1),#colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 0.75)]
        let skyBlue = [#colorLiteral(red: 0.3045541644, green: 0.6749247313, blue: 0.9517192245, alpha: 1),#colorLiteral(red: 0.008423916064, green: 0.4699558616, blue: 0.882807076, alpha: 1)]
        let blue = [#colorLiteral(red: 0.1774400771, green: 0.466574192, blue: 0.8732826114, alpha: 1),#colorLiteral(red: 0.00491155684, green: 0.287129879, blue: 0.7411141396, alpha: 1)]
        let bluePurple = [#colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        let purple = [#colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        let pink = [#colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 0.75)]
        
        let colorsTable: [Int: [UIColor]] = [0: red, 1: orangeRed, 2: orange, 3: yellow, 4: green, 5: greenBlue, 6: kindaBlue, 7: skyBlue, 8: blue, 9: bluePurple, 10: bluePurple, 11: purple, 12: pink]
        
        let randomColors = colorsTable.values.randomElement()
        return randomColors!
    }
    func setGradientBackgroundColor() {
        let colors = cellRandomBackgroundColors()
        self.typeContainer.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
    }

}


