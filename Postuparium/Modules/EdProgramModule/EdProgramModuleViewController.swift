//
//  EdProgramModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.11.2020.
//

import Foundation
import UIKit

class EdProgramModuleViewController: UIViewController, EdProgramModuleViewControllerProtocol, UISearchResultsUpdating, UISearchBarDelegate{
    
    var edProgramId: String!
    var presenter: EdProgramModulePresenterProtocol!
    
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var cellView: UIView!
    
    @IBAction func indexChanged(_ sender: Any) {
        updateView()
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
        setupView()
        
        
    
    }
    
    
    private lazy var firstViewController: ApplicantsTableViewController = {
        let storyboard = UIStoryboard(name: "EdProgramModule", bundle: Bundle.main)

        // Создали инстанс вью контроллера
      var viewController = storyboard.instantiateViewController(withIdentifier: "ApplicantsTableViewController") as! ApplicantsTableViewController
        
      self.add(asChildViewController: viewController)
    

        return viewController
    }()
    
    private lazy var secondViewController: SimilarModuleViewController = {
        // Load Storyboard
        print("in second")
        let storyboard = UIStoryboard(name: "EdProgramModule", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SimilarModuleViewController") as! SimilarModuleViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()
    
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Memory Management Methods
    //----------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Action Methods
    //----------------------------------------------------------------
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func setupSegmentedControl() {
        // Configure Segmented Control
    segmentedControl.removeAllSegments()
    segmentedControl.insertSegment(withTitle: "О направлении", at: 0, animated: false)
    segmentedControl.insertSegment(withTitle: "Похожие", at: 1, animated: false)
    segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        // Select First Segment
    segmentedControl.selectedSegmentIndex = 0
    }

    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //----------------------------------------------------------------

    private func add(asChildViewController viewController: UIViewController) {

        // Add Child View Controller
      addChild(viewController)

        // Add Child View as Subview
        containerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
      viewController.didMove(toParent: self)
    }

    //----------------------------------------------------------------

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
      viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()

      viewController.removeFromParent()
    }

    //----------------------------------------------------------------

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: secondViewController)
            add(asChildViewController: firstViewController)
        } else {
            remove(asChildViewController: firstViewController)
            add(asChildViewController: secondViewController)
        }
    }


    func setupView() {
    setupSegmentedControl()
    updateView()
    setupTopCellView()
    
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
        self.cellView.addSubview(cellView1)
    }
    


    
}
