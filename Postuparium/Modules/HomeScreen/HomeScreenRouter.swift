//
//  HomeScreenRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomeScreenRouter: HomeScreenRouterProtocol {
    
    weak var view: HomeScreenViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func showUniversityModuleScreen() {
        print("show university/edProgram module")
        let vc = UniversityModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
}
