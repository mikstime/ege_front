//
//  StartScreenInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

class StartScreenInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    
}
