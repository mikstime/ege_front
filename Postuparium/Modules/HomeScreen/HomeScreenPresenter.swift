//
//  HomeScreenPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomeScreenPresenter: HomeScreenPresenterProtocol {
    func showNewEdProgramsScreen() {
        router?.showNewEdProgramsScreen()
    }
    
    func showUniversitiesListScreen() {
        router?.showUniversitiesListScreen()
    }
    

    weak var view: HomeScreenViewControllerProtocol!
    var interactor: HomeScreenInteractorProtocol!
    var router: HomeScreenRouterProtocol!
    
    func showNextScreen() {
        router?.showUniversityModuleScreen()
    }
    
    func showMapScreen() {
        router?.showMapScreen()
    }
    
    func showPhotosScreen() {
        router?.showPhotosScreen()
    }
    
    func showNewEdProgramModuleScreen() {
        router?.showNewEdProgramModuleScreen()
    }
    
    func viewDidLoad() {
 
    }
    func showRegistrationScreen() {
        router?.showRegistrationScreen()
    }
}
