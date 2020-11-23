//
//  UniversityModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import UIKit

class UniversityModuleViewController: UICollectionViewController, UniversityModuleViewControllerProtocol, UITextFieldDelegate, UICollectionViewDelegateFlowLayout{
    
    var presenter: UniversityModulePresenterProtocol!
    var edPrograms: [EdProgramMock] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        let nib = UINib(nibName: "StudyTileMediumCell",bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")
        
        setupCollectionView()
        setupNavigationBarController()
    }
    
    //MARK : Properites
    let cellId = "Cell"
    
    //MARK : Setup Methods
    fileprivate func setupNavigationBarController() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Lists"

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }

    }
    fileprivate func setupCollectionView() {
        edPrograms = EdProgramMock.edProgramsList()
        
        collectionView?.backgroundColor = .white
        let customCellNib = UINib(nibName: "StudyTileMediumCell", bundle: .main)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: "StudyTileMediumCell")
        collectionView.alwaysBounceVertical = true
    }
    
    //MARK : CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return edPrograms.count + 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"StudyTileMediumCell", for: indexPath) as! StudyTileMediumCell
        
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
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == edPrograms.count){
            presenter?.showFeedbackScreen()
        } else{
            presenter?.showNextScreen(id: String(edPrograms[indexPath.row].id))
        }
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: (view.frame.width / 2) - 10 , height: 220)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }


    
}
