//
//  StartScreenViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class StartScreenViewController: UIViewController, StartScreenViewProtocol, UITextFieldDelegate {
    
    var presenter: StartScreenPresenterProtocol!
    var configurator: StartScreenConfiguratorProtocol = StartScreenConfigurator()
    
    let selfToAboutSegueName = "test"
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}
