//
//  ProgramsSelectionMenuRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionMenuRouter: ProgramsSelectionMenuRouterProtocol {
    
    weak var view: ProgramsSelectionMenuViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
}
