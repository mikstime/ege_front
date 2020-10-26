//
//  StartScreenRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class StartScreenRouter: StartScreenRouterProtocol {
    
    weak var viewController: StartScreenViewController!
    
    init(viewController: StartScreenViewController) {
        self.viewController = viewController
    }
    
    func showAboutScene() {
        viewController.performSegue(withIdentifier: viewController.selfToAboutSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
