//
//  AchievementsSelectionPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class AchievementsSelectionPresenter: AchievementsSelectionPresenterProtocol {

    weak var view: AchievementsSelectionViewControllerProtocol!
    var interactor: AchievementsSelectionInteractorProtocol!
    var router: AchievementsSelectionRouterProtocol!

    func viewDidLoad() {
        
    }
    
    func presentNextScreen() {
        router?.showProgramsSelectionScreen(enrollee: interactor?.getEnrollee() ?? Enrollee() )
    }
    
    func didToggleGoldenMedal(state: Bool) {
        interactor?.updateGoldenMedal(state: state)
    }
    
    func didToggleGto(state: Bool) {
        interactor?.updateGto(state: state)
    }
    
    func didToggleVolunteering(state: Bool) {
        interactor?.updateVolunteering(state: state)
    }
}
