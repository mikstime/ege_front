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
    
    func loadPrograms() {
        interactor.loadPrograms()
    }
    func viewDidLoad() {
        interactor.loadPrograms()
    }
    
    func showNextScreen(program: EdProgram) {
        router?.showEdProgramModuleScreen(program: program)
    }
    
    func showFeedbackScreen() {
        router?.showFeedBackModuleScreen()
    }
}

