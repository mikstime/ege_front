//
//  FeedbackModuleViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation

import UIKit

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

class FeedbackModuleViewController: UIViewController, LoadableScreen, FeedbackModuleViewControllerProtocol, UITextFieldDelegate {
    var message2: String! = "Отправка обращения"
    
    var message1: String! = "Еще немного..."
    
    var loader: UIView?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    var presenter: FeedbackModulePresenterProtocol!
    
    func didSubmit() {
        let alert = UIAlertController(title: "Ваше обращение зарегестрировано",
                                      message: "Вам ответят в течении нескольких дней", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Отлично!", style: .default, handler: {_ in
//            self.presenter?.showNextScreen()
            self.navigationController?.popViewController(animated: true)
        }))

        self.present(alert, animated: true)
    }
    
    func didNotSubmit() {
        let alert = UIAlertController(title: "Ваше обращение не зарегестрировано",
                                      message: "Не удалось зарегестрировать обращение по техническим причинам", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Очень жаль!", style: .default, handler: {_ in
        }))

        self.present(alert, animated: true)
        
    }
    
    @IBAction func showNextScreen() {
        let title = titleField.text ?? ""
        let message = textField.text ?? ""
        let email = emailField.text ?? ""
        if( title.isEmpty || message.isEmpty) {
            if title.isEmpty {
                titleField.attributedPlaceholder =
                NSAttributedString(string: "Например, ошибка в работе приложения", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            } else {
                titleField.attributedPlaceholder =
                    NSAttributedString(string: "Например, ошибка в работе приложения", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
            }
            if message.isEmpty {
                textField.attributedPlaceholder =
                NSAttributedString(string: "Сломалась кнопка помочь проекту", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            } else {
                textField.attributedPlaceholder =
                    NSAttributedString(string: "Сломалась кнопка помочь проекту", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
            }

        } else {
            presenter.didTapSubmit(email: email, message: message, title: title)
        }
    }
    
    final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    final override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    final override func viewDidLoad() {
        self.message1 = ""
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        presenter?.viewDidLoad()
        indentFields()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if heightConstraint.constant == 0 {
                heightConstraint.constant = keyboardSize.height - view.safeAreaInsets.bottom - 60
//                TopViewHeightConstraint.constant = 0
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if heightConstraint.constant != 0 {
//            TopViewHeightConstraint.constant = 136
            heightConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func indentFields() {
        titleField.leftViewMode = UITextField.ViewMode.always
        titleField.leftView = UIView(frame:CGRect(x:0, y:0, width:7, height:7))
        
        emailField.leftViewMode = UITextField.ViewMode.always
        emailField.leftView = UIView(frame:CGRect(x:0, y:0, width:7, height:7))
    }
    
}
