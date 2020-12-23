//
//  StartScreenPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit


// 1. 
class StartScreenPresenter: StartScreenPresenterProtocol {

    weak var view: StartScreenViewControllerProtocol!
    var interactor: StartScreenInteractorProtocol!
    var router: StartScreenRouterProtocol!
    
    required init(view: StartScreenViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor?.trySignin()
    }
    
    func didSignin(enrollee: Enrollee) {
        router?.showRegistrationScreen()
    }
    
    func didNotSignin() {
        router?.showRegistrationScreen()
//        router?.showHomeScreen()
    }
}
