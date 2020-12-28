//
//  HomePagePresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class HomePagePresenter: HomePagePresenterProtocol {
    weak var view: HomePageViewControllerProtocol!
    var interactor: HomePageInteractorProtocol!
    var router: HomePageRouterProtocol!
    
    func showProgram(program: EdProgram) {
        router?.showProgram(program: program)
    }
    func viewDidLoad() {
        interactor?.loadUniversities{ universities in
            self.view?.universities.universities = universities
        }
    }
}
