//
//  StartScreenInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

// 1. интерактор
class StartScreenInteractor: StartScreenInteractorProtocol {
    var presenter: StartScreenPresenterProtocol!

    required init(presenter: StartScreenPresenterProtocol) {
        self.presenter = presenter
    }
    
}
