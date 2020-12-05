//
//  UniversityModulePresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation
import UIKit

class UniversityModulePresenter: UniversityModulePresenterProtocol {
   
    

    weak var view: UniversityModuleViewControllerProtocol!
    var interactor: UniversityModuleInteractorProtocol!
    var router: UniversityModuleRouterProtocol!
    
    func viewDidLoad() {
        
    }
    func showNextScreen(id: String) {
        router?.showEdProgramModuleScreen(id: id)
    }
}

