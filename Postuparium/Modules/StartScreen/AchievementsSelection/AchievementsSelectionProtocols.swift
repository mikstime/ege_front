//
//  AchievementsSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol AchievementsSelectionViewControllerProtocol: UIViewController {
    var presenter: AchievementsSelectionPresenterProtocol! {get set}
}

protocol AchievementsSelectionPresenterProtocol: class {
    var router: AchievementsSelectionRouterProtocol! { set get }
    var view: AchievementsSelectionViewControllerProtocol! {set get}
    func viewDidLoad()
    
    func didToggleGoldenMedal(state: Bool)
    func didToggleGto(state: Bool)
    func didToggleVolunteering(state: Bool)
    
    func presentNextScreen()
}

protocol AchievementsSelectionInteractorProtocol: class {
    var presenter: AchievementsSelectionPresenterProtocol! {get set}
    func updateGoldenMedal(state:Bool)
    func updateGto(state:Bool)
    func updateVolunteering(state:Bool)
    func getEnrollee() -> Enrollee
}

protocol AchievementsSelectionRouterProtocol: class {
    var view: AchievementsSelectionViewControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    
    func showProgramsSelectionScreen(enrollee:Enrollee)
}

protocol AchievementsSelectionConfiguratorProtocol: class {
    static func configureModule(enrollee: Enrollee) -> AchievementsSelectionViewControllerProtocol
}
