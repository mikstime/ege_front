//
//  SettingsScreenRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class SettingsScreenRouter: SettingsScreenRouterProtocol {
    
    weak var view: SettingsScreenViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func showPhotosScreen() {
        let vc = PhotoTableViewConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showUniversitiesListScreen() {
        let vc = UniversitiesTableViewConfigurator.configureModule(hideHomePrograms: true)
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
}
