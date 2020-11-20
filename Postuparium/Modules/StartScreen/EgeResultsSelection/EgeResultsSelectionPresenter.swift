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

    var enrolleeModel: Enrollee!
        
    var view: EgeResultsSelectionViewControllerProtocol!
    var interactor: EgeResultsSelectionInteractorProtocol!
    var router: EgeResultsSelectionRouterProtocol!
    
    func viewDidLoad() {
        view.subjects = interactor.getSubjectsList()
    }
    
    func presentNextScreen(subjects: [SubjectDetails]) {
        interactor?.updateEnrolleeSubjects(subjects:subjects)
        router?.showAchievementsSelectionScreen(enrollee: interactor?.getEnrollee() ?? Enrollee())
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
