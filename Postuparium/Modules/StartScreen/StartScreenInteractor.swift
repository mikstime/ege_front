//
//  StartScreenInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

class StartScreenInteractor: StartScreenInteractorProtocol {
    
    weak var presenter: StartScreenPresenterProtocol!
    
    required init(presenter: StartScreenPresenterProtocol) {
        self.presenter = presenter
    }
    
    
}
