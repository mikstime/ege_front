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
    weak var interactor: AchievementsSelectionInteractorProtocol!
    var router: AchievementsSelectionRouterProtocol!

    func viewDidLoad() {
 
    }
    
    func presentNextScreen() {
        router?.showProgramsSelectionScreen()
    }
    
    func didToggleGoldenMedal(state: Bool) {
        //
    }
    
    func didToggleGto(state: Bool) {
        //
    }
    
    func didToggleVolunteere(state: Bool) {
        //
    }
}
