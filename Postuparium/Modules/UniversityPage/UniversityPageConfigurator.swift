//
//  UniversityPageConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class UniversityPageConfigurator: UniversityPageConfiguratorProtocol {
    
    static func configureModule() -> UniversityPageViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "UniversityPage", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в UniversityPage")
            return UniversityPageViewController()
        }
        
        let viewController = vc as! UniversityPageViewControllerProtocol
        let presenter = UniversityPagePresenter()
        let interactor = UniversityPageInteractor()
        let router = UniversityPageRouter()
        
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
