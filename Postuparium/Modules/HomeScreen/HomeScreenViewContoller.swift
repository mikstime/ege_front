//
//  HomeScreenViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class HomeScreenViewController: UIViewController, HomeScreenViewControllerProtocol, UITextFieldDelegate {
    
    var presenter: HomeScreenPresenterProtocol!
    
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
    
    @IBAction func showNewEdPrograms(_ sender: Any) {
        presenter?.showNewEdProgramsScreen()
    }
    
    @IBAction func showRegistrationScreen() {
        presenter?.showRegistrationScreen()
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
