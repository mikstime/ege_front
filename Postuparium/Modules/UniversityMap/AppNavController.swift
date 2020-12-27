//
//  AppNavController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 19.12.2020.
//

import UIKit

class AppNavController: UINavigationController, HalfModalPresentable {
    
    var id: Int = 0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("???")
        return isHalfModalMaximized() ? .default : .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.isNavigationBarHidden = true
        print("appnav", id)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("did appear appvav", id)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        print("perform in appnav")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navToModal" {
            if let destinationVC = segue.destination as? ModalViewController {
                destinationVC.id = id
            
            }
        }
    }
}
