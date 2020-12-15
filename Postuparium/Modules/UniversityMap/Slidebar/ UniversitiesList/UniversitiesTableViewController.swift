import Foundation
import UIKit

class UniversitiesTableViewController: UIViewController, UniversitiesTableViewControllerProtocol {
    
    @IBOutlet weak var universitiesTableView: UITableView!
    var presenter: UniversitiesTableViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.startLoad()
    }
    
    func configureTableView() {
        self.universitiesTableView.separatorStyle = .none

        self.universitiesTableView.dataSource = self
        self.universitiesTableView.delegate = self

        universitiesTableView.register(UINib(nibName: "EndTableViewCell", bundle: nil), forCellReuseIdentifier: "EndTableViewCell")
        universitiesTableView.register(UINib(nibName: "UniversityTableViewCell", bundle: nil), forCellReuseIdentifier: "UniversityTableViewCell")
    }
    
    func startLoad() {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            let endCell = self.universitiesTableView.cellForRow(at: indexPath) as! EndTableViewCell
            endCell.loader(animate: true)
            self.presenter?.fetch {
                DispatchQueue.main.async {
                    endCell.loader(animate: false)
                    self.universitiesTableView.reloadData()
                }
            }
            return
        }

        // тут вставитт логику работы с нажатием на ячейку таблицы университетов
    }
}
