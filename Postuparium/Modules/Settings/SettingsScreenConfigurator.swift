//
//  SettingsScreenConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class SettingsScreenConfigurator: SettingsScreenConfiguratorProtocol {
    
    static func configureModule() -> SettingsScreenViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "SettingsScreen", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в SettingsScreen")
            return SettingsScreenViewController()
        }
        
        let viewController = vc as! SettingsScreenViewControllerProtocol
        let presenter = SettingsScreenPresenter()
        let interactor = SettingsScreenInteractor()
        let router = SettingsScreenRouter()
        
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
