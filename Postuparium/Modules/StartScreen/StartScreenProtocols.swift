//
//  StartScreenProtocols.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//


import Foundation
import UIKit

protocol StartScreenViewProtocol: class {

}

protocol StartScreenPresenterProtocol: class {
    var router: StartScreenRouterProtocol! { set get }
    func configureView()
}

protocol StartScreenInteractorProtocol: class {

}

protocol StartScreenRouterProtocol: class {
    func showAboutScene()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol StartScreenConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}
