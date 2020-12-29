//
//  ProgramsSelectionPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionPresenter: ProgramsSelectionPresenterProtocol {

    weak var view: ProgramsSelectionViewControllerProtocol!
    var interactor: ProgramsSelectionInteractorProtocol!
    var router: ProgramsSelectionRouterProtocol!
    
    func showNextScreen() {
        view?.startLoading()
        interactor?.tryToCreateUser()
    }
    
    func viewDidLoad() {
        interactor?.searchForPrograms(searchString: "")
    }
    func requestMoreData() {
        interactor?.searchForPrograms(searchString: "")
    }
    func programsDidLoad(programs: [EdProgram]) {
        view?.programsDidLoad(programs: programs)
    }
    func didCreateUser() {
        view?.finishLoading()
        router?.showHomeScreen()
    }
    
    func didNotCreateUser() {
        view?.finishLoading()
        view?.showSignUpWarning()
    }
    func setPrograms(programs: [EdProgram]) {
        interactor?.setPrograms(programs: programs)
    }
    
    func searchPrograms(searchString: String) {
        interactor?.searchForPrograms(searchString: searchString)
    }
}
