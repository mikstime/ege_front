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
}

protocol EgeResultsSelectionPresenterProtocol: class {
    var view: EgeResultsSelectionViewControllerProtocol! {set get}
    var router: EgeResultsSelectionRouterProtocol! { set get }
    func viewDidLoad()
    func presentNextScreen(subjects: [SubjectDetails])
    func presentSkipScreen()
    // Вызывается интерактором после создания пользователя
    func didCreateUser()
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
