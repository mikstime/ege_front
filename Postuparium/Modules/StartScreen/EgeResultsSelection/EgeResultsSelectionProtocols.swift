//
//  EgeResultsSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol EgeResultsSelectionViewControllerProtocol: UIViewController {
    var presenter: EgeResultsSelectionPresenterProtocol! {get set}
    var subjects: [String] {get set}

    func startLoading()
    func finishLoading()
    func showSignUpWarning()
}

protocol EgeResultsSelectionPresenterProtocol: class {
    var view: EgeResultsSelectionViewControllerProtocol! {set get}
    var router: EgeResultsSelectionRouterProtocol! { set get }
    var interactor: EgeResultsSelectionInteractorProtocol! { set get }
    
    func viewDidLoad()
    func presentNextScreen(subjects: [SubjectDetails])
    func presentSkipScreen()
    // Вызываются интерактором после создания пользователя
    func didCreateUser()
    func didNotCreateUser()
}

protocol EgeResultsSelectionInteractorProtocol: class {
    var enrollee: Enrollee {get set}
    
    var presenter: EgeResultsSelectionPresenterProtocol! { get set }
    // Возвращает список предметов
    func getSubjectsList() -> [String]
    // Создать пользователя
    func tryToCreateUser()
    // Вернуть данные пользователя
    func getEnrollee() -> Enrollee
    // Сохраняет список предметов
    func updateEnrolleeSubjects(subjects: [SubjectDetails])
    
    func onError()
}

protocol EgeResultsSelectionRouterProtocol: class {
    var view: EgeResultsSelectionViewControllerProtocol! {set get}
    func showAchievementsSelectionScreen(enrollee: Enrollee)
    func showHomeScreen()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol EgeResultsSelectionConfiguratorProtocol: class {
    static func configureModule() -> EgeResultsSelectionViewControllerProtocol
}
