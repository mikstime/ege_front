//
//  UniversityMapPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

class UniversityMapPresenter: UniversityMapPresenterProtocol {
    
 
    weak var view: UniversityMapViewControllerProtocol!
    var interactor: UniversityMapInteractorProtocol!
    var router: UniversityMapRouterProtocol!
    
    func viewDidLoad() {
        
    }

    func showModal(id: Int) {
        print("В презентере ", id)
        self.router.showModal(id: id)
    }
    
    func showSettings() {
        router?.showSettings()
    }
}

