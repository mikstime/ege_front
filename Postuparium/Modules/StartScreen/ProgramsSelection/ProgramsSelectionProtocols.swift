//
//  ProgramsSelectionProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol ProgramsSelectionViewControllerProtocol: UIViewController {
    var presenter: ProgramsSelectionPresenterProtocol! {get set}
    func programsDidLoad(programs: [EdProgram])
}

protocol ProgramsSelectionPresenterProtocol: class {
    var router: ProgramsSelectionRouterProtocol! { set get }
    var view: ProgramsSelectionViewControllerProtocol! {get set}
    var interactor: ProgramsSelectionInteractorProtocol! {get set}
    func viewDidLoad()
    func showNextScreen()
    func requestMoreData()
    func programsDidLoad(programs: [EdProgram])
}

protocol ProgramsSelectionInteractorProtocol: class {
    var presenter: ProgramsSelectionPresenterProtocol! {get set}
    var enrollee: Enrollee {get set}
    func loadPrograms()
}

protocol ProgramsSelectionRouterProtocol: class {
    var view: ProgramsSelectionViewControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showHomeScreen()
}

protocol ProgramsSelectionConfiguratorProtocol: class {
    static func configureModule(enrollee: Enrollee) -> ProgramsSelectionViewControllerProtocol
}