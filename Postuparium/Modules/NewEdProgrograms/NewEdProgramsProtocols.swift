//
//  NewEdProgramsProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation

import UIKit

protocol NewEdProgramsViewControllerProtocol: UIViewController {
    var id: Int {set get}
    var presenter: NewEdProgramsPresenterProtocol! {get set}
}

protocol NewEdProgramsPresenterProtocol: class {
    var view: NewEdProgramsViewControllerProtocol! {set get}
    var router: NewEdProgramsRouterProtocol! { set get }
    
    func showNextScreen(id: String)
    func showFeedbackScreen()
    
    func viewDidLoad()
}

protocol NewEdProgramsInteractorProtocol: class {
    var presenter: NewEdProgramsPresenterProtocol! { get set }
}

protocol NewEdProgramsRouterProtocol: class {
    var view: NewEdProgramsViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showEdProgramModuleScreen(id: String)
    func showFeedBackModuleScreen()

}

protocol NewEdProgramsConfiguratorProtocol: class {
    static func configureModule() -> NewEdProgramsViewControllerProtocol
}
