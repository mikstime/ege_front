//
//  HomePageViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class ShadowView: UIView {
    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
            shadowLayer.fillColor = UIColor.systemBackground.cgColor

            shadowLayer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOpacity = 0.16
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowRadius = 6
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}

class ShadowButton: UIView {
    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
            shadowLayer.fillColor = UIColor.systemBackground.cgColor

            shadowLayer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOpacity = 0.16
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowRadius = 6
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}

class HomePageViewController: UIViewController, MenuViewControllerProtocol, HomePageViewControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var programs: UIView!
    var universities = UniversitiesTableViewConfigurator.configureModule()
    
    var presenter: HomePagePresenterProtocol!
    var handleArea: UIView!
    
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
        
        container?.layer.cornerRadius = 20
        container?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        handleArea = self.view
        presenter?.viewDidLoad()
        addUniversities()
    }
    func addUniversities(){
        if let view1 = universities.view {
            view.addSubview(view1)
            view1.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraint(NSLayoutConstraint(item: view1, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: view1, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: view1, attribute: .top, relatedBy: .equal, toItem: programs, attribute: .bottom, multiplier: 1, constant: 0))
            view1.addConstraint(NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 1000))
            addChild(universities)
        }
    }
}
