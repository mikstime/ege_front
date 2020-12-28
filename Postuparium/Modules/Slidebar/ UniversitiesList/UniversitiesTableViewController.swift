import Foundation
import UIKit

class UniversitiesTableViewController: UIViewController, UniversitiesTableViewControllerProtocol {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var universitiesTableView: UITableView!
//    @IBOutlet weak var homeProgramsView: HomePrograms!
    
    
    var presenter: UniversitiesTableViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.startLoad()
        self.designSearchBar()
    }
    
    func configureTableView() {
//        homeProgramsView.isHidden = presenter!.hideHomePrograms
        
        self.universitiesTableView.separatorStyle = .none

        self.universitiesTableView.dataSource = self
        self.universitiesTableView.delegate = self

        universitiesTableView.register(UINib(nibName: "EndTableViewCell", bundle: nil), forCellReuseIdentifier: "EndTableViewCell")
        universitiesTableView.register(UINib(nibName: "UniversityTableViewCell", bundle: nil), forCellReuseIdentifier: "UniversityTableViewCell")
        universitiesTableView.register(UINib(nibName: "EdProgramsViewCell", bundle: nil), forCellReuseIdentifier: "EdProgramsViewCell")
    }
    
    func startLoad() {
        print("load")
        self.universitiesTableView.isHidden = true
        self.presenter?.fetch {
            DispatchQueue.main.async {
                self.universitiesTableView.isHidden = false
                self.universitiesTableView.reloadData()
            }
        }
    }
}

extension UniversitiesTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getNumberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.row != 0 ) {
            return indexPath
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = self.universitiesTableView.dequeueReusableCell(withIdentifier: "EdProgramsViewCell") as! EdProgramsViewCell
            cell.dispatcher = self
            return cell
        }
        if (presenter!.isEndCell(indexPath: indexPath)) {
            let cell = self.universitiesTableView.dequeueReusableCell(withIdentifier: "EndTableViewCell") as! EndTableViewCell
            return cell
        }

        let cell = self.universitiesTableView.dequeueReusableCell(withIdentifier: "UniversityTableViewCell") as! UniversityTableViewCell
        presenter!.setCellData(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}


extension UniversitiesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        self.universitiesTableView.deselectRow(at: indexPath, animated: true)

        if (self.presenter!.isEndCell(indexPath: indexPath)) {
            self.presenter?.fetch {
                DispatchQueue.main.async {
                    self.universitiesTableView.reloadData()
                }
            }
            return
        }


        // тут вставитт логику работы с нажатием на ячейку таблицы университетов
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.presenter!.isEndCell(indexPath: indexPath)){
            return 68.0
        }
        if indexPath.row == 0 {
            return 252.0
        }
        return 196.0

    }
    
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

extension UniversitiesTableViewController: HomeProgramDispatcher {
    func programTapped(program: EdProgram) {
        presenter?.showProgram(program: program)
    }
}
