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
    
    func showAchievementsSelectionScreen() {
        let vc = AchievementsSelectionConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
    func showHomeScreen() {
        let vc = HomeScreenConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
//        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
//        guard let vc = storyboard.instantiateInitialViewController() else { return }
//        view?.navigationController!.show(vc, sender: view)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
