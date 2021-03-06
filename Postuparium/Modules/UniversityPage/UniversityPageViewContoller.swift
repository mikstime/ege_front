//
//  UniversityPageViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class UniversityPageViewController: UIViewController, UniversityPageViewControllerProtocol, CardViewControllerProtocol {
    var presenter: UniversityPagePresenterProtocol!
    var university: University! {
        didSet {
            universityHead.university = university
            universityDescription.university = university
            univerityPhotos.university = university
            universityPrograms.university = university
            chosenPrograms.university = university
        }
    }
    var handleArea: UIView!
    @IBOutlet weak var headContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIStackView!
    var universityHead = UniversityHead()
    var universityDescription = UniversityDescription()
    var univerityPhotos = UniversityPhotos()
    var chosenPrograms = HomePrograms()
    var universityPrograms = NewEdProgramsConfigurator.configureModule()
    override func viewDidLoad() {
        handleArea = self.view
        super.viewDidLoad()
        univerityPhotos.dispatcher = self
        presenter?.viewDidLoad()
        initHead()
        initDescription()
        initChosenPrograms()
        initPhotos()
        initPrograms()
    }
    
    func initHead() {
        universityHead.university = university
        headContainer.addSubview(universityHead)
        headContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: universityHead, attribute: .leading, relatedBy: .equal, toItem: headContainer, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityHead, attribute: .trailing, relatedBy: .equal, toItem: headContainer, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityHead, attribute: .top, relatedBy: .equal, toItem: headContainer, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityHead, attribute: .bottom, relatedBy: .equal, toItem: headContainer, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    func initDescription() {
        universityDescription.university = university
        containerView.addArrangedSubview(universityDescription)
        universityDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: universityDescription, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityDescription, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityDescription, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        containerView.sizeToFit()
        containerView.layoutIfNeeded()
    }
    
    func initChosenPrograms() {
        chosenPrograms.university = university
        containerView.addArrangedSubview(chosenPrograms)
        chosenPrograms.interactor.dispatcher = self
        chosenPrograms.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: chosenPrograms, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: chosenPrograms, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: chosenPrograms, attribute: .top, relatedBy: .equal, toItem: universityDescription, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: chosenPrograms, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 214).isActive = true
        containerView.sizeToFit()
        containerView.layoutIfNeeded()
    }
    
    func initPhotos() {
        univerityPhotos.university = university
        containerView.addArrangedSubview(univerityPhotos)
        univerityPhotos.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: univerityPhotos, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: univerityPhotos, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: univerityPhotos, attribute: .top, relatedBy: .equal, toItem: chosenPrograms, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        let heightConstraint = NSLayoutConstraint.init(item: univerityPhotos, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 273)
        heightConstraint.isActive = true
        univerityPhotos.heightConstraint = heightConstraint
        containerView.sizeToFit()
        containerView.layoutIfNeeded()
    }
    
    func initPrograms() {
        addChild(universityPrograms)
        universityPrograms.university = university
        containerView.addArrangedSubview(universityPrograms.view)
        universityPrograms.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: universityPrograms.view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityPrograms.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: universityPrograms.view, attribute: .top, relatedBy: .equal, toItem: univerityPhotos, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        let heightConstraint = NSLayoutConstraint.init(item: universityPrograms.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1235)
        heightConstraint.isActive = true
        universityPrograms.heightConstraint = heightConstraint
        containerView.layoutIfNeeded()
        containerView.sizeToFit()
    }
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

extension UniversityPageViewController: HomeProgramDispatcher {
    func programTapped(program: EdProgram) {
        let vc = NewEdProgramModuleConfigurator.configureModule(program: program)
        navigationController?.show(vc, sender: self)
    }
}

extension UniversityPageViewController: UniversityPhotoDispatcher {
    func didTapOnPhoto(photo: UIImage) {
        let vc = PhotoViewerConfigurator.configureModule(photo: photo)
        navigationController?.show(vc, sender: self)
    }
    
    func didTapOnMore() {
        let vc = PhotoTableViewConfigurator.configureModule()
        vc.presenter.interactor.photos = univerityPhotos.photos
        navigationController?.show(vc, sender: self)
    }
    
    
}
