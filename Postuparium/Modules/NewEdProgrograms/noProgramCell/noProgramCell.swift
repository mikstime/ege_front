//
//  no program.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import Foundation
import UIKit

class NoProgramCell: UICollectionViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
    }

}


