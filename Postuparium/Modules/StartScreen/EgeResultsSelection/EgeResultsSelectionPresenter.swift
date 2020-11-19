//
//  EgeResultsSelectionPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit


// 1.
class EgeResultsSelectionPresenter: EgeResultsSelectionPresenterProtocol {

    var view: EgeResultsSelectionViewControllerProtocol!
    var interactor: EgeResultsSelectionInteractorProtocol!
    var router: EgeResultsSelectionRouterProtocol!
    
    func viewDidLoad() {
        view.subjects = interactor.getSubjectsList()
    }
    
    func presentNextScreen() {
        router?.showAchievementsSelectionScreen()
    }
    
    func presentSkipScreen() {
        view?.startLoading()
        interactor?.tryToCreateUser()
    }
    
    func didCreateUser() {
        view?.finishLoading()
        router?.showHomeScreen()
    }
}
