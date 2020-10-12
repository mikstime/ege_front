//
//  StartScreenPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class StartScreenPresenter: StartScreenPresenterProtocol {

    weak var view: StartScreenViewProtocol!
    var interactor: StartScreenInteractorProtocol!
    var router: StartScreenRouterProtocol!
    
    required init(view: StartScreenViewProtocol) {
        self.view = view
    }
    
    func configureView() {
 
    }
}
