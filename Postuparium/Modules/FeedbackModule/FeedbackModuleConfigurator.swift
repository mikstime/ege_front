//
//  FeedbackModuleConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation
import UIKit

class FeedbackModuleConfigurator: FeedbackModuleConfiguratorProtocol {
    
    static func configureModule() -> FeedbackModuleViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "FeedbackModule", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в FeedbackModule")
            return FeedbackModuleViewController()
        }
        
        let viewController = vc as! FeedbackModuleViewControllerProtocol
        let presenter = FeedbackModulePresenter()
        let interactor = FeedbackModuleInteractor()
        let router = FeedbackModuleRouter()
        
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
