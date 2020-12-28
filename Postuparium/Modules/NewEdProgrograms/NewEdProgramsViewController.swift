//
//  NewEdProgramsViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation
import UIKit

extension UIView {
     func dropShadow(radius: CGFloat, offsetX: CGFloat, offsetY: CGFloat, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowOpacity = 1 // setting this property to 1 makes full relation on color's opacity
        layer.shadowColor = color.cgColor
    }
}

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}


class NewEdProgramsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewEdProgramsViewControllerProtocol {
    var id: Int = 0
    
    var presenter: NewEdProgramsPresenterProtocol!
    

    @IBOutlet var collection: UICollectionView!
    
    var edPrograms: [EdProgram] = []
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        
        let nib = UINib(nibName: "StudyTileMediumCell",bundle: nil)
        self.collection.register(nib, forCellWithReuseIdentifier: "StudyTileMediumCell")
//        setupCollectionView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //collection.reloadData()
    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyTileMediumCell", for: indexPath)
            as! StudyTileMediumCell
        
        if(indexPath.row < edPrograms.count ){
        let edProgram = edPrograms[indexPath.row]
            cell.codeLabel.text = edProgram.code
            cell.nameLabel.text = edProgram.name
//            cell.codeNameLabel.text = edProgram.codeName
//            cell.typeLabel.text = edProgram.edProgram
        } else{
            cell.codeLabel.text = ""
            cell.nameLabel.text = "Отсутствует направление?"
            cell.codeNameLabel.text = ""
            cell.typeLabel.text = "Напишите нам"
            cell.typeContainer.setGradientBackgroundColor(colorOne: .blue, colorTow: .systemBlue)
            
        }
//        cell.shadowDecorate()
    
            
        
        // Configure the cell
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0
        cell.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.gray.cgColor
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.16
        cell.layer.masksToBounds = false //<-
    
        
        return cell
    }

    
    
    //MARK : CollectionView Delegate Methods
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return edPrograms.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == edPrograms.count){
            presenter?.showFeedbackScreen()
        } else{
            presenter?.showNextScreen(program: edPrograms[indexPath.row])
        }
        
    }
    
    
    

}


extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 15
        contentView.layer.cornerRadius = radius
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.16
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
