//
//  AchievementsSelectionRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class AchievementsSelectionRouter: AchievementsSelectionRouterProtocol {
    weak var view: AchievementsSelectionViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func showProgramsSelectionScreen() {
        print("show 3 scr ceep")
        let vc = ProgramsSelectionConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
    }
    
}
