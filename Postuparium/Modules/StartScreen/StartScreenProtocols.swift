//
//  StartScreenProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol StartScreenViewControllerProtocol: UIViewController {
    
}

protocol StartScreenPresenterProtocol: class {
    var router: StartScreenRouterProtocol! { set get }
    func viewDidLoad()
    
    func didSignin(enrollee:Enrollee)
    func didNotSignin()
}

protocol StartScreenInteractorProtocol: class {
    
    var presenter: StartScreenPresenterProtocol! { get set }
    
    func trySignin()
}

protocol StartScreenRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showRegistrationScreen()
    func showHomeScreen()
}

protocol StartScreenConfiguratorProtocol: class {
    func configure(with viewController: StartScreenViewController)
}
