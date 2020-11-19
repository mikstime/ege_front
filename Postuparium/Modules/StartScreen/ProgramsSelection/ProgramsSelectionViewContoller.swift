//
//  ProgramsSelectionViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class ProgramsSelectionViewController: UIViewController, ProgramsSelectionViewControllerProtocol, UITextFieldDelegate {
    
    weak var presenter: ProgramsSelectionPresenterProtocol!
    
    @IBOutlet weak var titleView: UIStackView!
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        hideKeyboardWhenTappedAround()
//        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(showSecondViewController))
//        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.up
//        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    let sub = ProgramsSelectionMenu()
    
    @objc func hideProgramsSelectionMenu() {
//        NSLayoutConstraint.deactivate(sub.constraints)
//        let leadingConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
//        let trailingConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
//        let bottomConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
//        let heightConstraint = NSLayoutConstraint(item: sub, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.0, constant: 0.0)
//        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, heightConstraint, bottomConstraint])
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        sub.removeFromSuperview()
    }
    
    @IBAction func OpenProgramsSelectionMenu() {
        self.view.addSubview(sub)
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideProgramsSelectionMenu))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.down
        sub.addGestureRecognizer(swipeGestureRecognizer)
        let leadingConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view.superview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: sub, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.0, constant: 0.0)
        sub.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, heightConstraint, bottomConstraint])
        self.view.layoutIfNeeded()
        
        let topConstraint = NSLayoutConstraint(item: sub, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 24.0)

        heightConstraint.isActive = false
        topConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        self.view.bringSubviewToFront(sub)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
}
