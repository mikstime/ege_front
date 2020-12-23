//
//  ModalRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import UIKit
class ModalRouter: ModalRouterProtocol {
 
    
    weak var view: ModalViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue in modal")
        // prepare here some data for destination viewController
    }
    func showUniversityModuleScreen() {
        print("show university/edProgram module")
        let vc = UniversityModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
}
