//
//  NewEdProgramModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import Foundation
import UIKit

class NewEdProgramModuleViewController: UIViewController, NewEdProgramModuleViewControllerProtocol{
    
    
    
    var edProgramId: String!
    var presenter: NewEdProgramModulePresenterProtocol!
    
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        if ((edProgramId) != nil) {
            print("did load edProgram with id", edProgramId!)
        } else{
            print("did load edProgram no id")
        }
      
        
        
    
    }
    
    
  
    


 
    
    func setupTopCellView() {
        //todo брать из бека
        let edPrograms = EdProgramMock.edProgramsList()
        let edProgram = edPrograms[Int(edProgramId) ?? 0]
        
        let cellView1 = StudyTileBigCell.instanceFromNib() as! StudyTileBigCell
    
        
        cellView1.codeLabel.text = edProgram.code
        cellView1.nameLabel.text = edProgram.name
        cellView1.codeNameLabel.text = edProgram.codeName
        cellView1.typeLabel.text = edProgram.edProgram
//        self.cellView.addSubview(cellView1)
    }
    


    
}
