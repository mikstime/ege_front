//
//  ModalConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import UIKit

class ModalConfigurator: ModalConfiguratorProtocol {
    
    static func configureModule() -> ModalViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в Modal")
            return ModalViewController()
        }
        print("test1")
        let viewController = vc as! ModalViewControllerProtocol
        let presenter = ModalPresenter()
        let interactor = ModalInteractor()
        let router = ModalRouter()
        
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
