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
        // Initialization code
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        print("selected")
        
        // Configure the view for the selected state
    }
    
}
