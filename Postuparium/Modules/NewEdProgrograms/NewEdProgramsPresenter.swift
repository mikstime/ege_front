//
//  NewEdProgramsPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation
import UIKit

class NewEdProgramsPresenter: NewEdProgramsPresenterProtocol {
   
    

    weak var view: NewEdProgramsViewControllerProtocol!
    var interactor: NewEdProgramsInteractorProtocol!
    var router: NewEdProgramsRouterProtocol!
    
    func viewDidLoad() {
        
    }
    
    func showNextScreen(id: String) {
        router?.showEdProgramModuleScreen(id: id)
    }
    
    func showFeedbackScreen() {
        router?.showFeedBackModuleScreen()
    }
}

