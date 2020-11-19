//
//  EgeResultsConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class EgeResultsSelectionConfigurator: EgeResultsSelectionConfiguratorProtocol {
    
    func configure(with viewController: ViewController) {
        
    }
    
    
    static func configureModule() -> EgeResultsSelectionViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "EgeResultsSelection", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Не удалось найти входной контроллер в EgeResultsSelection")
            return EgeResultsSelectionViewController()
        }
        
        let viewController = vc as! EgeResultsSelectionViewControllerProtocol
        let presenter = EgeResultsSelectionPresenter()
        let interactor = EgeResultsSelectionInteractor()
        let router = EgeResultsSelectionRouter()
        
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
