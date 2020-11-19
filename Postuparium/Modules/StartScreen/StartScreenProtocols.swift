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
}

protocol StartScreenInteractorProtocol: class {
    
    var presenter: StartScreenPresenterProtocol! { get set }
    
}

protocol StartScreenRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showRegistrationScreen()
}

protocol StartScreenConfiguratorProtocol: class {
    func configure(with viewController: StartScreenViewController)
}
