//
//  HomeScreenConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomeScreenConfigurator: HomeScreenConfiguratorProtocol {
    
    static func configureModule() -> HomeScreenViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в HomeScreen")
            return HomeScreenViewController()
        }
        
        let viewController = vc as! HomeScreenViewControllerProtocol
        let presenter = HomeScreenPresenter()
        let interactor = HomeScreenInteractor()
        let router = HomeScreenRouter()
        
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
