//
//  ProgramsSelectionMenuConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionMenuConfigurator: ProgramsSelectionMenuConfiguratorProtocol {
    
    static func configureModule(enrollee: Enrollee = Enrollee()) -> ProgramsSelectionMenuViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "ProgramsSelectionMenu", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else { return ProgramsSelectionMenuViewController()}
        
        let viewController = vc as! ProgramsSelectionMenuViewControllerProtocol
        
        let presenter = ProgramsSelectionMenuPresenter()
        let interactor = ProgramsSelectionMenuInteractor()
        let router = ProgramsSelectionMenuRouter()
        
        interactor.enrollee = enrollee
        
        viewController.presenter = presenter
        router.view = viewController
        
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        
        return viewController
    }
    
}
