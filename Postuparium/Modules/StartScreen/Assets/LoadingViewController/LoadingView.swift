//
//  SpinnerView.swift
//  Postuparium
//
//  Created by Михаил on 19.11.2020.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var firstMessage: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    func _init() {
        fromNib()
    }
    
    func showLoading() {
        firstMessage.alpha = 0
        lastMessage.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.firstMessage.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            UIView.animate(withDuration: 1.5) {
                self.firstMessage.alpha = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                UIView.animate(withDuration: 1.5) {
                    self.lastMessage.alpha = 1
                }
            }
        }
        
    }
    func stopLoading() {
        
    }
}
protocol LoadableScreen: UIViewController {
    var loader: UIView? {get set}
}

extension LoadableScreen {
    
    func startLoading() {
        navigationController?.navigationBar.isHidden = true
        // Prevent creating several views
        if loader != nil {
            return
        }
        
        let loaderView = UIView.init(frame: view.bounds)
        loaderView.backgroundColor = UIColor.systemBackground
        let ai = LoadingView()
        
        DispatchQueue.main.async {
            self.view.addSubview(loaderView)
            loaderView.addSubview(ai)
            
            ai.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loaderView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loaderView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loaderView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: loaderView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
            ai.showLoading()
        }
        
        loader = loaderView
    }
    
    func finishLoading() {
        navigationController?.navigationBar.isHidden = false
        DispatchQueue.main.async {
            self.loader?.removeFromSuperview()
            self.loader = nil
        }
    }
    
    func showSignUpWarning() {
        let alert = UIAlertController(title: "Сетевая ошибка", message: "Не удалось соединиться с сервером. Повторите попытку позднее.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
