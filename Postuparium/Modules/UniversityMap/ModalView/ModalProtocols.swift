//
//  ModalProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import UIKit

protocol ModalViewControllerProtocol: UIViewController {
    var presenter: ModalPresenterProtocol! {get set}
//    var id: Int! {get set}
    
}

protocol ModalPresenterProtocol: class {
    var view: ModalViewControllerProtocol! {set get}
    var router: ModalRouterProtocol! { set get }
    
    func viewDidLoad()
}

protocol ModalInteractorProtocol: class {
    var presenter: ModalPresenterProtocol! { get set }
}

protocol ModalRouterProtocol: class {
    var view: ModalViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showUniversityModuleScreen()

}

protocol ModalConfiguratorProtocol: class {
    static func configureModule() -> ModalViewControllerProtocol
}
