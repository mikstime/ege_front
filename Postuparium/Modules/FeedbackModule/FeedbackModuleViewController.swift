//
//  FeedbackModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation

import UIKit

class FeedbackModuleViewController: UIViewController, FeedbackModuleViewControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var bigTextField: UITextField!
    
    var presenter: FeedbackModulePresenterProtocol!
    
    @IBAction func showNextScreen() {
        presenter?.showNextScreen()
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
        bigTextField.textAlignment = .left
        bigTextField.contentVerticalAlignment = .top
    }
    
}
