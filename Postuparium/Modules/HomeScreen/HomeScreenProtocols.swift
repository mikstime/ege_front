//
//  HomeScreenSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol HomeScreenViewControllerProtocol: UIViewController {
    var presenter: HomeScreenPresenterProtocol! {get set}
}

protocol HomeScreenPresenterProtocol: class {
    var view: HomeScreenViewControllerProtocol! {set get}
    var router: HomeScreenRouterProtocol! { set get }
    
    func showPhotosScreen()
    func showNextScreen()
    func showUniversitiesListScreen()
    func showMapScreen()
    func showNewEdProgramsScreen()
    func showRegistrationScreen()
    
    func viewDidLoad()
}

protocol HomeScreenInteractorProtocol: class {
    var presenter: HomeScreenPresenterProtocol! { get set }
}

protocol HomeScreenRouterProtocol: class {
    var view: HomeScreenViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func showUniversityModuleScreen()
    func showPhotosScreen()
    func showUniversitiesListScreen()
    func showNewEdProgramsScreen()
    func showMapScreen()
    func showRegistrationScreen()
}

protocol HomeScreenConfiguratorProtocol: class {
    static func configureModule() -> HomeScreenViewControllerProtocol
}
