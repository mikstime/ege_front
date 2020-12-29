//
//  StartScreenConfigurator.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class StartScreenConfigurator: StartScreenConfiguratorProtocol {
    
    func configure(with viewController: ViewController) {
        
    }
    
    
    func configure(with viewController: StartScreenViewController) {
        
        let presenter = StartScreenPresenter(view: viewController)
        let interactor = StartScreenInteractor(presenter: presenter)
        let router = StartScreenRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router

    }
}
