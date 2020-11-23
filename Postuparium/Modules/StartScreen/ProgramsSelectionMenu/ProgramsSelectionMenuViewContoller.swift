//
//  ProgramsSelectionMenuViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

protocol ProgramsSelectionMenuActionDispatcherProtocol {
    func didTapOnCell(row: Int, program:EdProgram)
    func requestForMoreData()
    func searchFor(searchString: String)
}

class ProgramsSelectionMenuViewController: UIViewController, ProgramsSelectionMenuViewControllerProtocol, UISearchBarDelegate, CardViewControllerProtocol {
    var totalOffset: CGFloat = 0.0
    var actionsDispatcher: ProgramsSelectionMenuActionDispatcherProtocol!
    var presenter: ProgramsSelectionMenuPresenterProtocol!
    var programs: [EdProgram] = []
    var selectedPrograms: [EdProgram] = []
    var isFetching = false
    
    var handleArea: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var handleAreaView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        handleArea = self.view
        super.viewDidLoad()
        searchBar.delegate = self
        presenter?.viewDidLoad()
        roundCornersAndAddShadow()
        designSearchBar()
        setupTableView()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        actionsDispatcher?.searchFor(searchString: searchBar.text!)
        self.programs = []
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

extension ProgramsSelectionMenuViewController {
    func designSearchBar() {
        searchBar.isTranslucent = false
        searchBar.barTintColor = UIColor.systemBackground
        searchBar.backgroundImage = UIImage()
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.systemBackground
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

extension ProgramsSelectionMenuViewController: UITableViewDelegate, UITableViewDataSource {
        
        func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
//            tableView.register(ProgramCell.self, forCellReuseIdentifier: "ProgramCell")
            tableView.register(UINib(nibName: "ProgramCell", bundle: nil), forCellReuseIdentifier: "ProgramCell")
        }
        
        // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return programs.count
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create a new cell if needed or reuse an old one
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCell", for: indexPath) as! ProgramCell
            // set the text from the data model
            cell.nameLabel.text = programs[indexPath.row].name
            cell.codeLabel.text = programs[indexPath.row].code

            cell.mark.isHidden = !selectedPrograms.contains { program in
                return program.id == programs[indexPath.row].id
            }
            
            return cell
        }
        
        // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contains = selectedPrograms.contains { program in
            return program.id == programs[indexPath.row].id
        }
        if contains {
            selectedPrograms = selectedPrograms.filter { $0.id != programs[indexPath.row].id }
        } else {
            selectedPrograms.append(programs[indexPath.row])
        }
        actionsDispatcher?.didTapOnCell(row: indexPath.row, program: programs[indexPath.row])
        tableView.reloadData()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            actionsDispatcher?.requestForMoreData()
        }
        updateHeight(offsetY: offsetY)
    }
    
    public func didLoadMoreData(newPrograms: [EdProgram]) {
        programs = programs + newPrograms
        self.tableView.reloadData()
    }
    
    func deselectProgram(program: EdProgram) {
        let ind = self.programs.firstIndex { $0.id == program.id }
        
        if let ind = ind {
            selectedPrograms = selectedPrograms.filter { $0.id != programs[ind].id }
            self.tableView.reloadData()
        }
    }
}
extension ProgramsSelectionMenuViewController {
    

    @objc private func updateHeight (offsetY: CGFloat) {
        if offsetY > 0 {
            if totalOffset == 200 {
                return
            }
            totalOffset = 200
        } else {
            if totalOffset == 0 {
                return
            }
            totalOffset = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = self.view.frame.height - 450 + 160 - self.totalOffset
        }
        
    }
}
