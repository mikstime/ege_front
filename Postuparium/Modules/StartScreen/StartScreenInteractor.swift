//
//  StartScreenInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

// 1. интерактор
class StartScreenInteractor: StartScreenInteractorProtocol {
    weak var presenter: StartScreenPresenterProtocol!

    required init(presenter: StartScreenPresenterProtocol) {
        self.presenter = presenter
    }
    
    func trySignin() {
        EnrolleeService.shared.signin {
            enrollee in
            if enrollee == nil {
                self.presenter?.didNotSignin()
            } else {
                self.presenter?.didSignin(enrollee: enrollee!)
            }
        }
    }
}
