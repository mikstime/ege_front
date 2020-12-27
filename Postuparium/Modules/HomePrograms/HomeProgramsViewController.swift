//
//  HomeProgramsViewController.swift
//  Postuparium
//
//  Created by Михаил on 26.12.2020.
//

import Foundation
import UIKit

@IBDesignable
class HomePrograms: UIView {
    var interactor = HomeProgramsInteractor()
    
    var programsViews: [HomeProgramView] = []
    
    @IBOutlet weak var programsContainer: UIStackView!
    @IBOutlet weak var ContainerWidthConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }

    func _init() {
        interactor.view = self
        interactor.loadPrograms()
        fromNib()
//        isExclusiveTouch = true
    }
    
    func programsAreLoaded(programs: [EdProgram]) {
        programs.forEach { program in
            let programView = HomeProgramView()
            programView.program = program
            programView.translatesAutoresizingMaskIntoConstraints = false
            programsContainer?.addSubview(programView)
            if let neighbour = programsViews.last {
                NSLayoutConstraint(item: programView, attribute: .leading, relatedBy: .equal, toItem: neighbour, attribute: .trailing, multiplier: 1, constant: 17).isActive = true
            } else {
                NSLayoutConstraint(item: programView, attribute: .leading, relatedBy: .equal, toItem: programsContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            }
            ContainerWidthConstraint.constant += 134
            programsViews.append(programView)
        }
    }
    
    func programsAreNotLoaded() {
        
        
    }
}
