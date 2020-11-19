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
//    final override func loadView() {
//        view = UIView()
//        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
//
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        view.addSubview(spinner)
//
//        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//    }
    
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
