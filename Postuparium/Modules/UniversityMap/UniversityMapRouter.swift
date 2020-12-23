//
//  UniversityMapRouter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

class UniversityMapRouter: UniversityMapRouterProtocol {
    

    weak var view: UniversityMapViewControllerProtocol!
    
    
    var id: Int = 0
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        
        print("prepare")
        view.self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: view.self, presentingViewController: segue.destination)
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = view.halfModalTransitioningDelegate
        
        if segue.identifier == "fromAnnotationMap" {
            if let destinationVC = segue.destination as? AppNavController {
                print("set id in segue map",id)
                destinationVC.id = id
            
            }
        }
    }
    
    
    func showModal(id: Int) {
        
        print("В роутере ", id)
        self.id = id
        self.view.performSegue(withIdentifier: "fromAnnotationMap", sender: self.view)
        
    }
    
    func showSettings() {
        
    }
    
}
