//
//  NewEdProgramModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 27.12.2020.
//

import Foundation
import UIKit

class NewEdProgramModuleViewController: UIViewController, NewEdProgramModuleViewControllerProtocol{
    
    
    @IBOutlet weak var topCellVIew: ShadowView!
    @IBOutlet weak var topCellLabel: UILabel!
    @IBOutlet weak var topCellCodeLabel: UILabel!
    @IBOutlet weak var topCellTypeContainer: UIView!
    @IBOutlet weak var topCellTypeLabel: UILabel!
    
    @IBOutlet weak var topCellCodeNameLabel: UILabel!
    @IBOutlet weak var probLabel: UILabel!
    var program: EdProgram! {// СОДЕРЖИТ ИНФОРМАЦИЮ О НАПРАВЛЕНИИ. ВЫСТАВЛЯЕТСЯ КОНФИГУРАТОРОМ
        didSet {
            if program.code.count > 1 {
                topCellCodeLabel?.text = String(program.name.first ?? "Э") + String(program.code[1] )
            }
            probLabel?.text = program.probability
            topCellLabel?.text = program.name
            topCellCodeNameLabel?.text = program.code
            topCellTypeLabel?.text = program.university
        }
    }
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
        setupTopCellView()
        

        
        if ((edProgramId) != nil) {
            print("did load edProgram with id", edProgramId!)
        } else{
            print("did load edProgram no id")
        }
      
        
        
    
    }
    
    
  
    


 
    
    func setupTopCellView() {
        //todo брать из бека
        topCellVIew.layer.cornerRadius = 15.0
        topCellVIew.layer.borderWidth = 0
        topCellVIew.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.gray.cgColor
        topCellVIew.layer.shadowOffset = .zero
        topCellVIew.layer.shadowRadius = 6.0
        topCellVIew.layer.shadowOpacity = 0.16
//
        if program.code.count > 1 {
            topCellCodeLabel.text = String(program.name.first ?? "Э") + String(program.code[1] )
        }
        probLabel.text = program.probability
        topCellLabel.text = program.name
        topCellCodeNameLabel.text = program.code
        topCellTypeLabel.text = program.university
        let colors = cellRandomBackgroundColors()
        topCellTypeContainer.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
        topCellTypeContainer.roundCorners([.topRight, .bottomRight, .bottomLeft], radius: 15)
//        topCellVIew.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: 15)
//        topCellVIew.layer.contents = UIImage()
        
    
        
    }
    


    
    func cellRandomBackgroundColors() -> [UIColor] {
  
        return [UIColor(named: "BlueGradientTop") ?? #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 0.87), UIColor(named: "BlueGradientBottom") ?? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)]
    }
}

