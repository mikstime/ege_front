//
//  ProgramsSelectionRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionRouter: ProgramsSelectionRouterProtocol {
    
    weak var view: ProgramsSelectionViewControllerProtocol!
    
    init() {}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
