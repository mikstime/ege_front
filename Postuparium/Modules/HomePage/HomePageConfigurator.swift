//
//  HomePageConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomePageConfigurator: HomePageConfiguratorProtocol {
    
    static func configureModule() -> HomePageViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в HomePage")
            return HomePageViewController()
        }
        
        let viewController = vc as! HomePageViewControllerProtocol
        let presenter = HomePagePresenter()
        let interactor = HomePageInteractor()
        let router = HomePageRouter()
        
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
