//
//  NewEdProgramModuleProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import Foundation
import UIKit

protocol NewEdProgramModuleViewControllerProtocol: UIViewController {
    var presenter: NewEdProgramModulePresenterProtocol! {get set}
    var edProgramId: String! {get set}
    
}

protocol NewEdProgramModulePresenterProtocol: class {
    var view: NewEdProgramModuleViewControllerProtocol! {set get}
    var router: NewEdProgramModuleRouterProtocol! { set get }
    
    func viewDidLoad()
}

protocol NewEdProgramModuleInteractorProtocol: class {
    var presenter: NewEdProgramModulePresenterProtocol! { get set }
}

protocol NewEdProgramModuleRouterProtocol: class {
    var view: NewEdProgramModuleViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)

}

protocol NewEdProgramModuleConfiguratorProtocol: class {
    static func configureModule() -> NewEdProgramModuleViewControllerProtocol
}
