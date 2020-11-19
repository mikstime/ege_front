//
//  ProgramsSelectionConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionConfigurator: ProgramsSelectionConfiguratorProtocol {
    
    static func configureModule() -> ProgramsSelectionViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "ProgramsSelection", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else { return ProgramsSelectionViewController()}
        
        let viewController = vc as! ProgramsSelectionViewControllerProtocol
        
        let presenter = ProgramsSelectionPresenter()
        let interactor = ProgramsSelectionInteractor()
        let router = ProgramsSelectionRouter()
        viewController.presenter = presenter
        router.view = viewController
        presenter.view = viewController
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
}
