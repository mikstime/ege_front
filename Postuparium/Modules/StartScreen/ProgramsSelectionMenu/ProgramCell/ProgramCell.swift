//
//  ProgramCell.swift
//  Postuparium
//
//  Created by Михаил on 21.11.2020.
//

import UIKit

class ProgramCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var mark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {

    }
}
