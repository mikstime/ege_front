import Foundation
import UIKit

protocol UniversitiesTableViewControllerDispatcher: class {
    func didTapOnUniversity(university: University)
    func didStartEditing()
}
class UniversitiesTableViewController: UIViewController, UniversitiesTableViewControllerProtocol, UISearchBarDelegate {
    var universities: [University] = [] {
        didSet {
            universitiesToShow = universities
            self.universitiesTableView.reloadData()
        }
    }
    var universitiesToShow: [University] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var universitiesTableView: UITableView!
//    @IBOutlet weak var homeProgramsView: HomePrograms!
    
    weak var dispatcher: UniversitiesTableViewControllerDispatcher!
    
    var presenter: UniversitiesTableViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.startLoad()
        searchBar?.delegate = self
        self.designSearchBar()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dispatcher?.didStartEditing()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        universitiesToShow = universities.filter { u in
            return u.name.lowercased().contains(searchText)
        }
        self.universitiesTableView.reloadData()
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
//        self.universitiesTableView.isHidden = true
//        self.presenter?.fetch {
//            DispatchQueue.main.async {
////                self.universitiesTableView.isHidden = false
//                self.universitiesTableView.reloadData()
//            }
//        }
    }
}

extension UniversitiesTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universitiesToShow.count > 0 ? universitiesToShow.count + 1: 1
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
//        if (presenter!.isEndCell(indexPath: indexPath)) {
//            let cell = self.universitiesTableView.dequeueReusableCell(withIdentifier: "EndTableViewCell") as! EndTableViewCell
//            return cell
//        }

        let cell = self.universitiesTableView.dequeueReusableCell(withIdentifier: "UniversityTableViewCell") as! UniversityTableViewCell
//        presenter!.setCellData(cell: cell, indexPath: indexPath)
        cell.university = universitiesToShow[indexPath.row - 1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        designSearchBar()
    }
}


extension UniversitiesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        self.universitiesTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            return
        }
        
//        if (self.presenter!.isEndCell(indexPath: indexPath)) {
//            self.presenter?.fetch {
//                DispatchQueue.main.async {
//                    self.universitiesTableView.reloadData()
//                }
//            }
//            return
//        }
        
        if let dispatcher = dispatcher {
            dispatcher.didTapOnUniversity(university: universitiesToShow[indexPath.row - 1] )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 252.0
        }
        
//        if (self.presenter!.isEndCell(indexPath: indexPath)){
//            return 68.0
//        }
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
