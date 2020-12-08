//
//  FeedbackModulePresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation
import UIKit

class FeedbackModulePresenter: FeedbackModulePresenterProtocol {

    weak var view: FeedbackModuleViewControllerProtocol!
    var interactor: FeedbackModuleInteractorProtocol!
    var router: FeedbackModuleRouterProtocol!
    
    func showNextScreen() {
        router?.showUniversityModuleScreen()
    }
    
    func viewDidLoad() {
 
    }
}
