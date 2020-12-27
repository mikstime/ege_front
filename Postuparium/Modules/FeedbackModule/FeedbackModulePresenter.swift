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
    
    func didTapSubmit(email: String, message: String, title: String) {
        view?.startLoading()
        interactor?.send(email: email, message: message, title: title, onFinish: {status in
            self.view?.finishLoading()
            if(status) {
                self.view?.didSubmit()
            } else{
                self.view?.didNotSubmit()
            }
        }
        )
    }
}
