//
//  ProgramsSelectionRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionRouter: ProgramsSelectionRouterProtocol {
    
    weak var view: ProgramsSelectionViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func showHomeScreen() {
        print("show home")
        let vc = UniversityMapConfigurator.configureModule()
        view?.navigationController!.show(vc as UIViewController, sender: view)
        
//        let vc = HomeScreenConfigurator.configureModule()
        
//        view?.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
//        view?.navigationController?.navigationBar.shadowImage = nil
//
//        view?.navigationController?.show(vc as UIViewController, sender: nil)
    }
}
