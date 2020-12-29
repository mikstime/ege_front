//
//  NewEdProgramModuleViewRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import Foundation
import UIKit
class NewEdProgramModuleRouter: NewEdProgramModuleRouterProtocol {
 
    
    weak var view: NewEdProgramModuleViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
