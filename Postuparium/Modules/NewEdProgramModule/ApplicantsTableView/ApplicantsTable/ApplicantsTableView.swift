//
//  ApplicantsTableView.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

import UIKit

class ApplicantsTableViewController: UITableViewController {
    
    
//  @IBOutlet var tableView: UITableView!
  
  var applicants: [Applicant] = []
  
    func loadApplicants(applicants: [Applicant]) {
    
        self.applicants = applicants
        tableView.reloadData()
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    ApplicantsService.shared.searchForApplicants(query: "", didFind: loadApplicants)

    
    let cellNib = UINib(nibName: "ApplicantCell", bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier:
                                "ApplicantCell")
    
  
    
   
    

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
//    if let indexPath = tableView.indexPathForSelectedRow {
//        self.tableView.deselectRow(at: indexPath, animated: true)
//    }
  }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

      return applicants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicantCell", for: indexPath) as? ApplicantCell else {
            fatalError("Pizdec")
        }
      
        let applicant: Applicant = applicants[indexPath.row]
        print("applicant \(indexPath.row)", applicant)

        cell.name?.text = applicant.name
        if applicant.scores == 282 {
            cell.name?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.score?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.index?.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            cell.name?.font = UIFont.systemFont(ofSize: 16)
            cell.score?.font = UIFont.systemFont(ofSize: 16)
            cell.index?.font = UIFont.systemFont(ofSize: 16)
        }
        cell.score?.text = "\(applicant.scores)"
        cell.index?.text = "\(indexPath.row + 1)"
        

    
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select on \(indexPath.row)", applicants[indexPath.row])
    }

  
}



extension UITableView {

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
