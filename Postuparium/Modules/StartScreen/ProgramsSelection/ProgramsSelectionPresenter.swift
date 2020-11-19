//
//  ProgramsSelectionPresenter.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
import UIKit

class ProgramsSelectionPresenter: ProgramsSelectionPresenterProtocol {

    weak var view: ProgramsSelectionViewControllerProtocol!
    var interactor: ProgramsSelectionInteractorProtocol!
    var router: ProgramsSelectionRouterProtocol!
    
    required init() {}
    
    func viewDidLoad() {
        //
    }
}
