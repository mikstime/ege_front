//
//  UniversityPageSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol UniversityPageViewControllerProtocol: CardViewControllerProtocol {
    var presenter: UniversityPagePresenterProtocol! {get set}
}

protocol UniversityPagePresenterProtocol: class {
    var view: UniversityPageViewControllerProtocol! {set get}
    var router: UniversityPageRouterProtocol! { set get }
    
    func viewDidLoad()
}

protocol UniversityPageInteractorProtocol: class {
    var presenter: UniversityPagePresenterProtocol! { get set }
}

protocol UniversityPageRouterProtocol: class {
    var view: UniversityPageViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol UniversityPageConfiguratorProtocol: class {
    static func configureModule() -> UniversityPageViewControllerProtocol
}
