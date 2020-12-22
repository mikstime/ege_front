//
//  ModalViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 19.12.2020.
//

import Foundation

import UIKit

struct University {
    var label: String
    var bgImage: String
}


class ModalViewController: UIViewController, ModalViewControllerProtocol, HalfModalPresentable,
                           UITableViewDelegate, UITableViewDataSource{
    var id: Int = 0
    
    let universities = UniversitiesMock.UniversitiesList()

    
    var presenter: ModalPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func maximazeButtonTapped(sender: AnyObject) {

        maximizeToFullScreen()
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
  
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerTableViewCells()
        
    
        if let parentVC = self.navigationController as? AppNavController {
            self.id = parentVC.id // set variable here

        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("modal did appear", id)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue prepare modal", id, segue.destination)
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }


    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "UnoversityCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "UnoversityCell")
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           print("click")
       }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UnoversityCell") as? UnoversityCell {
            let univer = universities[indexPath.row]
            
            cell.label?.text = univer.name
            
            cell.returnValue = { value in
             
                self.maximizeToFullScreen()
                
                let vc = UniversityModuleConfigurator.configureModule()
                vc.id = self.universities[indexPath.row].id
                self.navigationController!.show(vc as UIViewController, sender: self)

                   }
            
            
            let url = URL(string: univer.preview)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
    
                    cell.bgImage?.image =  UIImage(data: data!)
                }
            }

        
            cell.selectionStyle = .none
            cell.bgImage?.backgroundColor = .black
//            cell.contentView.backgroundColor = .black
            
            return cell
    }
        return UITableViewCell()


}
}



