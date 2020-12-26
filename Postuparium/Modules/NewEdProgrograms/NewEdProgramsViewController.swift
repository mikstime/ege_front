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
    
    var edPrograms: [EdProgramMock] = []
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        edPrograms = EdProgramMock.edProgramsList()
        
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
        cell.codeNameLabel.text = edProgram.codeName
        cell.typeLabel.text = edProgram.edProgram
        } else{
            cell.codeLabel.text = ""
            cell.nameLabel.text = "Отсутствует направление?"
            cell.codeNameLabel.text = ""
            cell.typeLabel.text = "Напишите нам"
            cell.setGradientBackgroundColor(colorOne: .blue, colorTow: .systemBlue)
            cell.typeContainer.setGradientBackgroundColor(colorOne: .blue, colorTow: .systemBlue)
            
        }
        cell.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.black, radius: 20, opacity: 0.5)
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
            presenter?.showNextScreen(id: String(edPrograms[indexPath.row].id))
        }
        
    }
    
    
    

}
