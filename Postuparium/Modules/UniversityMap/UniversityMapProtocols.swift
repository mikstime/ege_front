//
//  UniversityMapProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

protocol UniversityMapViewControllerProtocol: UIViewController {
    var idUn: Int { get set }
    var presenter: UniversityMapPresenterProtocol! {get set}
    var halfModalTransitioningDelegate:HalfModalTransitioningDelegate! { set get }
}

protocol UniversityMapPresenterProtocol: class {
    var view: UniversityMapViewControllerProtocol! {set get}
    var router: UniversityMapRouterProtocol! { set get }
    
    func showModal(id: Int)

    
    func viewDidLoad()
}

protocol UniversityMapInteractorProtocol: class {
    var presenter: UniversityMapPresenterProtocol! { get set }
}

protocol UniversityMapRouterProtocol: class {
    
    var view: UniversityMapViewControllerProtocol! {set get}
    var id: Int {set get }
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showModal(id: Int)
//    func showEdProgramModuleScreen(id: String)
//    func showFeedBackModuleScreen()

}

protocol UniversityMapConfiguratorProtocol: class {
    static func configureModule() -> UniversityMapViewControllerProtocol
}

