//
//  SettingsScreenViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class SettingsScreenViewController: UIViewController, SettingsScreenViewControllerProtocol, UITextFieldDelegate {
    
    var presenter: SettingsScreenPresenterProtocol!
    
    @IBAction func showNextScreen() {
        presenter?.showNextScreen()
    }
    
    @IBAction func showMapScreen() {
        presenter?.showMapScreen()
    }
    
    @IBAction func showUniversitiesListScreen() {
        presenter?.showUniversitiesListScreen()
    }
    
    @IBAction func showPhotosScreen() {
        presenter?.showPhotosScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}
