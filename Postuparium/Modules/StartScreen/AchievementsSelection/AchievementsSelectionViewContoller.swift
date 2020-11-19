//
//  AchievementsSelectionViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class AchievementsSelectionViewController: UIViewController, AchievementsSelectionViewControllerProtocol, UITextFieldDelegate {
    
    var presenter: AchievementsSelectionPresenterProtocol!
    
    let selfToAboutSegueName = "AchievementsSelection"
    
    @IBOutlet weak var goldenMedalItem: AchievementsItem!
    @IBOutlet weak var gtoItem: AchievementsItem!
    @IBOutlet weak var volunteeringItem: AchievementsItem!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        linkActions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func toggleGoldenMedal(sender:UISwitch!) {
        print("toggled gm")
    }
    
    @objc func toggleGto(sender:UISwitch!) {
        print("toggled gto")
    }
    
    @objc func toggleVolunteering(sender:UISwitch!) {
        print("toggled vo")
    }
    
    private func linkActions() {
        goldenMedalItem.uiSwitch.addTarget(self, action: #selector(toggleGoldenMedal), for: .valueChanged)
        gtoItem.uiSwitch.addTarget(self, action: #selector(toggleGto), for: .valueChanged)
        volunteeringItem.uiSwitch.addTarget(self, action: #selector(toggleVolunteering), for: .valueChanged)
    }
    
    @IBAction func nextScreen() {
        self.presenter?.presentNextScreen()
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}
