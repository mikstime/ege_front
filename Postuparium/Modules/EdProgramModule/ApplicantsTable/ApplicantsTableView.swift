//
//  ApplicantsTableView.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

import UIKit

class ApplicantsTableViewController: UIViewController {
    
    
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
  
  var applicants: [ApplicantMock] = []
  let searchController = UISearchController(searchResultsController: nil)
  var filteredApplicants: [ApplicantMock] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    applicants = ApplicantMock.applicantsList()
    
    // 1
    searchController.searchResultsUpdater = self
    // 2
    searchController.obscuresBackgroundDuringPresentation = false
    // 3
    searchController.searchBar.placeholder = "Поиск"

    // 4
    navigationItem.searchController = searchController
    // 5
    definesPresentationContext = true
    
    searchController.searchBar.scopeButtonTitles = ApplicantMock.Category.allCases.map { $0.rawValue }
    searchController.searchBar.center.x = view.frame.width / 2


    searchController.searchBar.delegate = self
    
    searchController.searchBar.showsScopeBar = true

    searchController.searchBar.showsCancelButton = false
    
    
    
  
    
    
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
    notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
    
    self.tableView.tableHeaderView = searchController.searchBar
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  

  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  category: ApplicantMock.Category? = nil) {
    filteredApplicants = applicants.filter { (applicant: ApplicantMock) -> Bool in
      let doesCategoryMatch = category == .all || applicant.category == category
      
      if isSearchBarEmpty {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && applicant.name.lowercased().contains(searchText.lowercased())
      }
    }
    
    tableView.reloadData()
  }
  
  func handleKeyboard(notification: Notification) {
    // 1
    guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
//      searchFooterBottomConstraint.constant = 0
      view.layoutIfNeeded()
      return
    }
    

    // 2
//    let keyboardHeight = keyboardFrame.cgRectValue.size.height
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
  }
}

extension ApplicantsTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return filteredApplicants.count
    }
    return applicants.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let applicant: ApplicantMock
    if isFiltering {
      applicant = filteredApplicants[indexPath.row]
    } else {
      applicant = applicants[indexPath.row]
    }
    cell.textLabel?.text = applicant.name
    cell.detailTextLabel?.text = applicant.category.rawValue
    return cell
  }
}

extension ApplicantsTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let category = ApplicantMock.Category(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    filterContentForSearchText(searchBar.text!, category: category)
  }
}

extension ApplicantsTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    let category = ApplicantMock.Category(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, category: category)
  }
}
