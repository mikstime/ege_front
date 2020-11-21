//
//  ProgramsSelectionViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class ProgramsSelectionViewController: SwipeableViewController, ProgramsSelectionViewControllerProtocol, UITextFieldDelegate {
    var presenter: ProgramsSelectionPresenterProtocol!
//    @IBOutlet weak var titleView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectedProgramsView: UIStackView!
    @IBOutlet weak var selectedProgramsHeightConstraint: NSLayoutConstraint!
    
    @IBAction func showNextScreen() {
        presenter?.showNextScreen()
    }
    var menu: ProgramsSelectionMenuViewControllerProtocol!
    override func viewDidLoad() {
        menu = ProgramsSelectionMenuConfigurator.configureModule()
        menu.actionsDispatcher = self
        cardViewController = menu
        super.viewDidLoad()
        presenter?.viewDidLoad()
        hideKeyboardWhenTappedAround()
        updateSelectedProgramsView()
        setupScrollView()
        view.layoutIfNeeded()
    }
    func setupScrollView() {
        view.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
    
    @IBAction func OpenProgramsSelectionMenu() {
        menu.totalOffset = 0
        showCard()
    }
    
    func initProgramView() {
        var program = EdProgram()
        program.code = "1.1.1"
        program.id = 4
        program.name = "Информационные технологии"
        addProgram(program: program)
        self.view.layoutIfNeeded()
        updateSelectedProgramsView()
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        if selectedProgramsView.subviews.count > 3 {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}

extension ProgramsSelectionViewController: ProgramsSelectionItemDispatcherProtocol {
    
    func updateSelectedProgramsView() {
        if selectedProgramsView.subviews.count == 0 {
            selectedProgramsHeightConstraint.constant = 0
        } else if selectedProgramsView.subviews.count == 1 {
            selectedProgramsHeightConstraint.constant = 58
        } else if selectedProgramsView.subviews.count == 2 {
            selectedProgramsHeightConstraint.constant = 58 * 2 + 20
        } else if selectedProgramsView.subviews.count == 3 {
            selectedProgramsHeightConstraint.constant = 58 * 3 + 20 * 2
        } else {
            selectedProgramsHeightConstraint.constant = 58 * 3 + 20 * 3 + 6
        }
    }
    
    func addProgram(program: EdProgram) {
        let programView = ProgramsSelectionItem()
        programView.source = program
        programView.translatesAutoresizingMaskIntoConstraints = false
        selectedProgramsView.addArrangedSubview(programView)
        
        programView.actionDispatcher = self
        
        NSLayoutConstraint(item: programView, attribute: .leading, relatedBy: .equal, toItem: selectedProgramsView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: programView, attribute: .trailing, relatedBy: .equal, toItem: selectedProgramsView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: programView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 58).isActive = true
        
    }
    
    func tappedRemoveProgram(programView: ProgramsSelectionItem!) {
        programView.removeFromSuperview()
        menu.deselectProgram(program: programView.source)
        updateSelectedProgramsView()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ProgramsSelectionViewController: ProgramsSelectionMenuActionDispatcherProtocol {

    func didTapOnCell(row: Int, program: EdProgram) {
        let thatView = selectedProgramsView.subviews.first { programView in
            let pw = programView as? ProgramsSelectionItem ?? ProgramsSelectionItem()
            if pw.source.id == program.id {
                return true
            } else {
                return false
            }
        }
        if thatView != nil {
            thatView?.removeFromSuperview()
            updateSelectedProgramsView()
            self.view.layoutIfNeeded()
        } else {
            addProgram(program: program)
            self.view.layoutIfNeeded()
            updateSelectedProgramsView()
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            if selectedProgramsView.subviews.count > 3 {
                let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
                scrollView.setContentOffset(bottomOffset, animated: true)
            }
        }
    }
    
    func requestForMoreData() {
        presenter?.requestMoreData()
    }
    
    func programsDidLoad(programs: [EdProgram]) {
        menu?.didLoadMoreData(newPrograms: programs)
    }
    
}
