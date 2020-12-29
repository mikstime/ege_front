//
//  FeedbackModuleProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//


import Foundation
import UIKit

protocol FeedbackModuleViewControllerProtocol: LoadableScreen {
    var presenter: FeedbackModulePresenterProtocol! {get set}
    func didSubmit()
    func didNotSubmit()
}

protocol FeedbackModulePresenterProtocol: class {
    var view: FeedbackModuleViewControllerProtocol! {set get}
    var router: FeedbackModuleRouterProtocol! { set get }
    func showNextScreen()
    func didTapSubmit(email: String, message: String, title: String)
    func viewDidLoad()
}

protocol FeedbackModuleInteractorProtocol: class {
    var presenter: FeedbackModulePresenterProtocol! { get set }
    func send(email: String, message: String, title: String, onFinish:@escaping (Bool) -> Void)
}

protocol FeedbackModuleRouterProtocol: class {
    var view: FeedbackModuleViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func showUniversityModuleScreen()
}

protocol FeedbackModuleConfiguratorProtocol: class {
    static func configureModule() -> FeedbackModuleViewControllerProtocol
}
