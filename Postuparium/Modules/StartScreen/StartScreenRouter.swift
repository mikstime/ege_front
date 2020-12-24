//
//  StartScreenRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class StartScreenRouter: StartScreenRouterProtocol {
    
    weak var viewController: StartScreenViewControllerProtocol!
    
    init(viewController: StartScreenViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func showRegistrationScreen() {
        let vc = UniversitiesTableViewConfigurator.configureModule()
       // let vc = ProgramsSelectionConfigurator.configureModule()
//        let vc = EgeResultsSelectionConfigurator.configureModule()
        viewController?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        viewController?.navigationController?.navigationBar.shadowImage = nil
        viewController?.navigationController!.show(vc, sender: viewController)
    }
    
    func showHomeScreen() {
        print("go to home")
        let vc = HomeScreenConfigurator.configureModule()
//        let vc = UniversityMapConfigurator.configureModule()
        viewController?.navigationController!.show(vc as UIViewController, sender: viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
