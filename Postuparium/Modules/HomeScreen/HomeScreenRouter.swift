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
    
    func showPhotosScreen() {
        let vc = PhotoTableViewConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showUniversitiesListScreen() {
        let vc = UniversitiesTableViewConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showMapScreen() {
        let vc = UniversityMapConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showUniversityModuleScreen() {
        print("show university/edProgram module")
        let vc = UniversityModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showNewEdProgramsScreen() {
        print("show university/edProgram module")
        let vc = NewEdProgramsConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showNewEdProgramModuleScreen() {
        print("show edProgram module")
        let vc = NewEdProgramModuleConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showRegistrationScreen() {
        let vc = EgeResultsSelectionConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
}
