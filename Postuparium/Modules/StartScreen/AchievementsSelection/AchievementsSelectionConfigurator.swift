//
//  AchievementsSelectionConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class AchievementsSelectionConfigurator: AchievementsSelectionConfiguratorProtocol {
    
    static func configureModule(enrollee: Enrollee = Enrollee()) -> AchievementsSelectionViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "AchievementsSelection", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Root contoller was not found in AchievementsSelection storyboard")
            return AchievementsSelectionViewController()
        }
        
        let viewController = vc as! AchievementsSelectionViewControllerProtocol
        
        let presenter = AchievementsSelectionPresenter()
        let interactor = AchievementsSelectionInteractor()
        let router = AchievementsSelectionRouter()
        
        interactor.enrollee = enrollee
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }
}
