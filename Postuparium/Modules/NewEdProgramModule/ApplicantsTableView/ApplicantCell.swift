//
//  ApplicantCell.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import UIKit

class ApplicantCell: UITableViewCell {

    @IBOutlet weak var index: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
