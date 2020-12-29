//
//  HomePageRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomePageRouter: HomePageRouterProtocol {
    
    weak var view: HomePageViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    func showProgram(program: EdProgram) {
        let vc = NewEdProgramModuleConfigurator.configureModule()
        view?.navigationController?.show(vc, sender: view)
    }
}
