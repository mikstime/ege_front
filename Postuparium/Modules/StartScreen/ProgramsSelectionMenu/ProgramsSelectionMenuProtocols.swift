//
//  ProgramsSelectionMenuProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol ProgramsSelectionMenuViewControllerProtocol: CardViewControllerProtocol {
    var totalOffset: CGFloat {get set}
    var presenter: ProgramsSelectionMenuPresenterProtocol! {get set}
    var actionsDispatcher: ProgramsSelectionMenuActionDispatcherProtocol! {get set}
    func didLoadMoreData(newPrograms: [EdProgram])
    func deselectProgram(program: EdProgram)
}

protocol ProgramsSelectionMenuPresenterProtocol: class {
    var router: ProgramsSelectionMenuRouterProtocol! { set get }
    var view: ProgramsSelectionMenuViewControllerProtocol! {get set}
    func viewDidLoad()
}

protocol ProgramsSelectionMenuInteractorProtocol: class {
    var presenter: ProgramsSelectionMenuPresenterProtocol! {get set}
    var enrollee: Enrollee {get set}
}

protocol ProgramsSelectionMenuRouterProtocol: class {
    var view: ProgramsSelectionMenuViewControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol ProgramsSelectionMenuConfiguratorProtocol: class {
    static func configureModule(enrollee: Enrollee) -> ProgramsSelectionMenuViewControllerProtocol
}
