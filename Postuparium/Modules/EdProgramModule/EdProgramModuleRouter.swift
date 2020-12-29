//
//  EdProgramModuleRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.11.2020.
//

import Foundation
import UIKit
class EdProgramModuleRouter: EdProgramModuleRouterProtocol {
 
    
    weak var view: EdProgramModuleViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}

