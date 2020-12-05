//
//  UniversityModuleConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import Foundation
import UIKit

class UniversityModuleConfigurator: UniversityModuleConfiguratorProtocol {
    
    static func configureModule() -> UniversityModuleViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "UniversityModule", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в UniversityModule")
            return UniversityModuleViewController()
        }
        
        let viewController = vc as! UniversityModuleViewControllerProtocol
        let presenter = UniversityModulePresenter()
        let interactor = UniversityModuleInteractor()
        let router = UniversityModuleRouter()
        
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
