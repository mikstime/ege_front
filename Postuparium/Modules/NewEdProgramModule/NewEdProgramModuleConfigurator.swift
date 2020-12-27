//
//  NewEdProgramModuleConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import Foundation
import UIKit

class NewEdProgramModuleConfigurator: NewEdProgramModuleConfiguratorProtocol {
    
    static func configureModule() -> NewEdProgramModuleViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "NewEdProgramModule", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в NewEdProgramModule")
            return NewEdProgramModuleViewController()
        }
        let viewController = vc as! NewEdProgramModuleViewControllerProtocol
        let presenter = NewEdProgramModulePresenter()
        let interactor = NewEdProgramModuleInteractor()
        let router = NewEdProgramModuleRouter()
        
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
