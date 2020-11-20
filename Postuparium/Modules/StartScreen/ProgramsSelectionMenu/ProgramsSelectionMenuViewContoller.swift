//
//  ProgramsSelectionMenuViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class ProgramsSelectionMenuViewController: UIViewController, ProgramsSelectionMenuViewControllerProtocol, CardViewControllerProtocol {
    
    var handleArea: UIView!
    var presenter: ProgramsSelectionMenuPresenterProtocol!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        handleArea = self.view
        super.viewDidLoad()
        presenter?.viewDidLoad()
        roundCornersAndAddShadow()
        designSearchBar()
    }

    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

extension ProgramsSelectionMenuViewController {
    func designSearchBar() {
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
                
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.borderWidth = 1
            textfield.cornerRadius = 10
            textfield.borderColor = UIColor.systemGray5
        }
    }
}
extension ProgramsSelectionMenuViewController {
    
    func roundCornersAndAddShadow() {
        container.layer.cornerRadius = 20
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        container.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        container.layer.shadowOpacity = 0.16
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 6
    }
    
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }

        container.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
    }
}
