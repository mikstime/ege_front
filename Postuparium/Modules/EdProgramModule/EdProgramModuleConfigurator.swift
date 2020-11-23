//
//  EdProgramModuleConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.11.2020.
//

import Foundation
import UIKit

class EdProgramModuleConfigurator: EdProgramModuleConfiguratorProtocol {
    
    static func configureModule() -> EdProgramModuleViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "EdProgramModule", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в EdProgramModule")
            return EdProgramModuleViewController()
        }
        print("test1")
        let viewController = vc as! EdProgramModuleViewControllerProtocol
        let presenter = EdProgramModulePresenter()
        let interactor = EdProgramModuleInteractor()
        let router = EdProgramModuleRouter()
        
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
