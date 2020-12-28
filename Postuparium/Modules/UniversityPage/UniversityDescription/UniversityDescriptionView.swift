//
//  UniversityDescription.swift
//  Postuparium
//
//  Created by Михаил on 28.12.2020.
//

import UIKit

class UniversityDescription: UIView {
    var university: University! {
        didSet {
            setDetails()
        }
    }
    var isExpanded = false
    @IBOutlet weak var toggleDetailsButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func toggleDetails() {
        if isExpanded {
            descriptionLabel?.numberOfLines = 5
            toggleDetailsButton?.setTitle("ПОДРОБНЕЕ", for: .normal)
        } else {
            descriptionLabel?.numberOfLines = 20
            toggleDetailsButton?.setTitle("МЕНЬШЕ", for: .normal)
        }
        isExpanded = !isExpanded
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
        setDetails()
    }
    
    func setDetails() {
        descriptionLabel?.text = (university?.description ?? "")
        
    }
}
