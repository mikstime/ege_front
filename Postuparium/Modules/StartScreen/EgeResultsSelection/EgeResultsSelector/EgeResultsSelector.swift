//
//  EgeResultsSelector.swift
//  Postuparium
//
//  Created by Михаил on 13.11.2020.
//

import UIKit

@IBDesignable
class EgeResultsSelector: UIView {
    
    let subjects = ["Русский язык", "Математика", "Физика",
                    "Химия", "История", "Обществознание", "ИКТ", "Биология",
                    "География", "Английский зык", "Немецкий язык", "Французский язык",
                    "Китайский язык", "Испанский язык", "Литература"]
    
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var subjectPicker: UIPickerView!
    @IBOutlet weak var score: UITextField!

    @IBInspectable var startPosition: Int = 0
    
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
        _init_picker()
    }

}

extension EgeResultsSelector: UIPickerViewDataSource, UIPickerViewDelegate {
    
    private func _init_picker() {
        subjectPicker?.dataSource = self
        subjectPicker?.delegate = self
        
        subjectPicker?.selectRow(startPosition * subjects.count, inComponent: 0, animated: false)
        
        if #available(iOS 14.0, *)
        {
            let transparent = UIColor(red: 255.0 , green: 255.0, blue: 255.0, alpha: 0.0)
            subjectPicker?.subviews[1].backgroundColor = transparent
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: subjects[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
    }
}

extension EgeResultsSelector: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

        let limitNumber = Int(textField.text! + string) ?? -1

        if string == "0" && textField.text?.isEmpty ?? true {
            return false
        }
        
        if limitNumber < 0 || limitNumber > 100 {
            
            if(limitNumber > 100) {
                textField.text = "100"
            } else {
                textField.text = ""
            }
            
            return false
        } else {
            return true
        }
    }
    
}
