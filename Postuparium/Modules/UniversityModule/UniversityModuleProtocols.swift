//
//  UniversityModuleProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import Foundation
import UIKit

protocol UniversityModuleViewControllerProtocol: UIViewController {
    var presenter: UniversityModulePresenterProtocol! {get set}
}

protocol UniversityModulePresenterProtocol: class {
    var view: UniversityModuleViewControllerProtocol! {set get}
    var router: UniversityModuleRouterProtocol! { set get }
    
    func showNextScreen(id: String)
    
    func viewDidLoad()
}

protocol UniversityModuleInteractorProtocol: class {
    var presenter: UniversityModulePresenterProtocol! { get set }
}

protocol UniversityModuleRouterProtocol: class {
    var view: UniversityModuleViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showEdProgramModuleScreen(id: String)

}

protocol UniversityModuleConfiguratorProtocol: class {
    static func configureModule() -> UniversityModuleViewControllerProtocol
}
