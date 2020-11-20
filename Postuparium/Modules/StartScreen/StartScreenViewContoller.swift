//
//  StartScreenViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class StartScreenViewController: UIViewController, StartScreenViewControllerProtocol {

    weak var presenter: StartScreenPresenterProtocol!
    var configurator: StartScreenConfiguratorProtocol = StartScreenConfigurator()

    final override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter?.viewDidLoad()
    }
}
