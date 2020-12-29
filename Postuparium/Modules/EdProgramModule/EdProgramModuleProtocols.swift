//
//  EdProgramModuleProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.11.2020.
//

import Foundation
import UIKit

protocol EdProgramModuleViewControllerProtocol: UIViewController {
    var presenter: EdProgramModulePresenterProtocol! {get set}
    var edProgramId: String! {get set}
    
}

protocol EdProgramModulePresenterProtocol: class {
    var view: EdProgramModuleViewControllerProtocol! {set get}
    var router: EdProgramModuleRouterProtocol! { set get }
    
    func viewDidLoad()
}

protocol EdProgramModuleInteractorProtocol: class {
    var presenter: EdProgramModulePresenterProtocol! { get set }
}

protocol EdProgramModuleRouterProtocol: class {
    var view: EdProgramModuleViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)

}

protocol EdProgramModuleConfiguratorProtocol: class {
    static func configureModule() -> EdProgramModuleViewControllerProtocol
}
