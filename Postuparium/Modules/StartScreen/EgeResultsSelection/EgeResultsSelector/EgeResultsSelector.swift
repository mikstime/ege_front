//
//  EgeResultsSelector.swift
//  Postuparium
//
//  Created by Михаил on 13.11.2020.
//

import UIKit

protocol EgeResulsActionDispatcher {
    
    func didSelectRow()
    
    func tappedDelete(view: EgeResultsSelector)
}
@IBDesignable
class EgeResultsSelector: UIView {
    
    var actionDispatcher: EgeResulsActionDispatcher!
    
    var subjects: [String] = []
    var forbiddenRow = 0
    
    @IBOutlet weak var container: UIStackView!
    @IBOutlet weak var subjectPicker: UIPickerView!
    @IBOutlet weak var score: UITextField!
    @IBOutlet weak var deletionButton: UIButton!

    @IBInspectable var isError: Bool = false {
        didSet {
            subjectPicker.reloadAllComponents()
        }
    }
    
    @IBAction func tappedDelete() {
        actionDispatcher?.tappedDelete(view: self)
    }
    
    @IBInspectable var shouldFill: Bool = true {
        didSet {
            if score.text!.isEmpty {
                score.attributedPlaceholder = NSAttributedString(string:score.placeholder != nil ? score.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemRed])
            } else {
                score.attributedPlaceholder = NSAttributedString(string:score.placeholder != nil ? score.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: UIColor.placeholderText])
            }
        }
    }
    
    @IBInspectable var startPosition: Int = 0 {
        didSet {
            subjectPicker.reloadAllComponents() // without reload does not set (another solution is to hardcode subjects)
            subjectPicker?.selectRow(startPosition, inComponent: 0, animated: false)
        }
    }
    
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
        isExclusiveTouch = true
    }

}

extension EgeResultsSelector: UIPickerViewDataSource, UIPickerViewDelegate {
    
    private func _init_picker() {
        subjectPicker?.dataSource = self
        subjectPicker?.delegate = self
        
        subjectPicker?.selectRow(startPosition, inComponent: 0, animated: false)
        if #available(iOS 14.0, *)
        {
            let transparent = UIColor(red: 255.0 , green: 255.0, blue: 255.0, alpha: 0.0)
            subjectPicker?.subviews[1].backgroundColor = transparent
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel: UILabel
        
        if let label = view as? UILabel {
            pickerLabel = label
        } else {
            pickerLabel = UILabel()
            // Customize text
            pickerLabel.font = pickerLabel.font.withSize(20)
            pickerLabel.textAlignment = .left
            // Create a paragraph with custom style
            // We only need indents to prevent text from being cut off
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = 12 // May vary
            // Create a string and append style to it
            let attributedString = NSMutableAttributedString(string: subjects[row])
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            // Update label's text
            pickerLabel.attributedText = attributedString
        }
        
        if isError && row == forbiddenRow {
            pickerLabel.textColor = UIColor.systemRed
        } else {
            pickerLabel.textColor = UIColor.secondaryLabel
        }
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        actionDispatcher?.didSelectRow()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row % subjects.count]
        
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
        
        shouldFill = false
        
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
