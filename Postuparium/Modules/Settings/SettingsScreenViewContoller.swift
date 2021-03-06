//
//  SettingsScreenViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class SettingsScreenViewController: UIViewController, CardViewControllerProtocol, SettingsScreenViewControllerProtocol {
    var handleArea: UIView!
    
    var presenter: SettingsScreenPresenterProtocol!
    @IBAction func showFeedback() {
        let vc = FeedbackModuleConfigurator.configureModule()
        navigationController?.show(vc, sender: self)
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
        handleArea = self.view
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}
