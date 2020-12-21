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
        print("did appear", id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue prepare appnav", id)
    }
}
