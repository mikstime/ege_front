//
//  NewEdProgramsConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation
import UIKit

class NewEdProgramsConfigurator: NewEdProgramsConfiguratorProtocol {
    
    static func configureModule() -> NewEdProgramsViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "NewEdPrograms", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в NewEdPrograms")
            return NewEdProgramsViewController() as! NewEdProgramsViewControllerProtocol
        }
        
        let viewController = vc as! NewEdProgramsViewControllerProtocol
        let presenter = NewEdProgramsPresenter()
        let interactor = NewEdProgramsInteractor()
        let router = NewEdProgramsRouter()
        
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
