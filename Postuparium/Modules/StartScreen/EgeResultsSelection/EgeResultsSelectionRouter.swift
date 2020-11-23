//
//  EgeResultsSelectionRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class EgeResultsSelectionRouter: EgeResultsSelectionRouterProtocol {
    
    weak var view: EgeResultsSelectionViewControllerProtocol!
    
    func showAchievementsSelectionScreen(enrollee:Enrollee) {
        let vc = AchievementsSelectionConfigurator.configureModule(enrollee: enrollee)
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showHomeScreen() {
        let vc = HomeScreenConfigurator.configureModule()
        
        view?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        view?.navigationController?.navigationBar.shadowImage = nil
        
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
