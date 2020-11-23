//
//  FeedbackModuleProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//


import Foundation
import UIKit

protocol FeedbackModuleViewControllerProtocol: UIViewController {
    var presenter: FeedbackModulePresenterProtocol! {get set}
}

protocol FeedbackModulePresenterProtocol: class {
    var view: FeedbackModuleViewControllerProtocol! {set get}
    var router: FeedbackModuleRouterProtocol! { set get }
    func showNextScreen()
    
    func viewDidLoad()
}

protocol FeedbackModuleInteractorProtocol: class {
    var presenter: FeedbackModulePresenterProtocol! { get set }
}

protocol FeedbackModuleRouterProtocol: class {
    var view: FeedbackModuleViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func showUniversityModuleScreen()
}

protocol FeedbackModuleConfiguratorProtocol: class {
    static func configureModule() -> FeedbackModuleViewControllerProtocol
}
