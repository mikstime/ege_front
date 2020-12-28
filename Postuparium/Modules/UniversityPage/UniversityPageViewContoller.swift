//
//  UniversityPageViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class UniversityPageViewController: UIViewController, UniversityPageViewControllerProtocol, CardViewControllerProtocol {
    var presenter: UniversityPagePresenterProtocol!
    var university: University!
    var handleArea: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        handleArea = self.view
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}
