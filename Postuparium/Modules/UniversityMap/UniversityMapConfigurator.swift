//
//  UniversityMapConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

class UniversityMapConfigurator: UniversityMapConfiguratorProtocol {
    
    static func configureModule() -> UniversityMapViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "UniversityMap", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в UniversityMap")
            return UniversityMapViewController()
        }
        
        let viewController = vc as! UniversityMapViewControllerProtocol
        let presenter = UniversityMapPresenter()
        let interactor = UniversityMapInteractor()
        let router = UniversityMapRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        presenter.view = viewController
        presenter.view = viewController
        
        presenter.interactor = interactor
        
        presenter.router = router
        
        return viewController
    }
}

