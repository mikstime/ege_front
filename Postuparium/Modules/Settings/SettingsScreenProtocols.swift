//
//  SettingsScreenSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol SettingsScreenViewControllerProtocol: CardViewControllerProtocol {
    var presenter: SettingsScreenPresenterProtocol! {get set}
}

protocol SettingsScreenPresenterProtocol: class {
    var view: SettingsScreenViewControllerProtocol! {set get}
    var router: SettingsScreenRouterProtocol! { set get }
    
    func showPhotosScreen()
    func showNextScreen()
    func showUniversitiesListScreen()
    func showMapScreen()
    func viewDidLoad()
}

protocol SettingsScreenInteractorProtocol: class {
    var presenter: SettingsScreenPresenterProtocol! { get set }
}

protocol SettingsScreenRouterProtocol: class {
    var view: SettingsScreenViewControllerProtocol! {set get}
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func showUniversityModuleScreen()
    func showPhotosScreen()
    func showUniversitiesListScreen()
    func showMapScreen()
}

protocol SettingsScreenConfiguratorProtocol: class {
    static func configureModule() -> SettingsScreenViewControllerProtocol
}
