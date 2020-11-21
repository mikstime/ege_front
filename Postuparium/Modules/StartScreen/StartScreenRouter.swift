//
//  StartScreenRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class StartScreenRouter: StartScreenRouterProtocol {
    
    weak var viewController: StartScreenViewControllerProtocol!
    
    init(viewController: StartScreenViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func showRegistrationScreen() {

//        let vc = PhotoTableViewConfigurator.configureModule()
//        viewController?.navigationController!.show(vc as UITableViewController, sender: nil)

        let vc = EgeResultsSelectionConfigurator.configureModule()
//        let vc = ProgramsSelectionConfigurator.configureModule()
        viewController?.navigationController!.show(vc as UIViewController, sender: nil)
//        let storyboard = UIStoryboard(name: "EgeResultsSelection", bundle: nil)
//        guard let vc = storyboard.instantiateInitialViewController() else { return }
//        print("did load")
//        viewController.navigationController!.show(vc as UIViewController, sender: viewController)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
