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
}

protocol ProgramsSelectionPresenterProtocol: class {
    var router: ProgramsSelectionRouterProtocol! { set get }
    var view: ProgramsSelectionViewControllerProtocol! {get set}
    func viewDidLoad()
}

protocol ProgramsSelectionInteractorProtocol: class {
    var presenter: ProgramsSelectionPresenterProtocol! {get set}
}

protocol ProgramsSelectionRouterProtocol: class {
    var view: ProgramsSelectionViewControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol ProgramsSelectionConfiguratorProtocol: class {
    static func configureModule() -> ProgramsSelectionViewControllerProtocol
}
