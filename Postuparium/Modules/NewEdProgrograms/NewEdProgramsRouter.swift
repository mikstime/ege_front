//
//  NewEdProgramsRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation

import UIKit

class NewEdProgramsRouter: NewEdProgramsRouterProtocol {

    weak var view: NewEdProgramsViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
        if let vc = segue.destination as? EdProgramModuleViewControllerProtocol {
            vc.edProgramId = "1"
        }
    }
    
    func showEdProgramModuleScreen(program: EdProgram) {
        let vc = NewEdProgramModuleConfigurator.configureModule(program: program)
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showFeedBackModuleScreen() {
        print("show feedbackModule ")
        let vc = FeedbackModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
}
