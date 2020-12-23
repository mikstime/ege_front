//
//  ModalPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import UIKit

class ModalPresenter: ModalPresenterProtocol {

    weak var view: ModalViewControllerProtocol!
    var interactor: ModalInteractorProtocol!
    var router: ModalRouterProtocol!
    
    func viewDidLoad() {
        
    }
}
