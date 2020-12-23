//
//  UniversityModuleRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import Foundation
import UIKit
class UniversityModuleRouter: UniversityModuleRouterProtocol {

 
    
    weak var view: UniversityModuleViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
        if let vc = segue.destination as? EdProgramModuleViewControllerProtocol {
            vc.edProgramId = "1"
            }
    }
    
    func showEdProgramModuleScreen(id: String) {
        print("show edProgram module with id ", id)
        let vc = EdProgramModuleConfigurator.configureModule()
        vc.edProgramId = id
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showFeedBackModuleScreen() {
        print("show feedbackModule ")
        let vc = FeedbackModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
}
