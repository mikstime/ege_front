//
//  UnoversityCell.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import UIKit

class UnoversityCell: UITableViewCell {

    @IBOutlet weak var label: UILabel?
    
    @IBOutlet weak var bgImage: UIImageView?
    
    @IBAction func openUniversityScreen(_ sender: Any) {
        returnValue?(id)
    }
    
    var id: Int = 0
    
    //callback function
       var returnValue: (( _ value: Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let overlay: UIView = UIView(frame: self.contentView.frame)
//        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
//        self.bgImage?.addSubview(overlay)
        // Initialization code
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
}
