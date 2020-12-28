//
//  HomePageSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol HomePageViewControllerProtocol: MenuViewControllerProtocol {
    var presenter: HomePagePresenterProtocol! {get set}
}

protocol HomePagePresenterProtocol: class {
    var view: HomePageViewControllerProtocol! {set get}
    var router: HomePageRouterProtocol! { set get }
    func showProgram(program: EdProgram)
    func viewDidLoad()
}

protocol HomePageInteractorProtocol: class {
    var presenter: HomePagePresenterProtocol! { get set }
}

protocol HomePageRouterProtocol: class {
    var view: HomePageViewControllerProtocol! {set get}
    
    func showProgram(program: EdProgram)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol HomePageConfiguratorProtocol: class {
    static func configureModule() -> HomePageViewControllerProtocol
}
