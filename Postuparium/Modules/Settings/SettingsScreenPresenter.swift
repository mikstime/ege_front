//
//  SettingsScreenPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class SettingsScreenPresenter: SettingsScreenPresenterProtocol {
    func showUniversitiesListScreen() {
        router?.showUniversitiesListScreen()
    }
    

    weak var view: SettingsScreenViewControllerProtocol!
    var interactor: SettingsScreenInteractorProtocol!
    var router: SettingsScreenRouterProtocol!
    
    func showNextScreen() {
        router?.showUniversityModuleScreen()
    }
    
    func showMapScreen() {
        router?.showMapScreen()
    }
    
    func showPhotosScreen() {
        router?.showPhotosScreen()
    }
    
    func viewDidLoad() {
 
    }
}
