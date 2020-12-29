//
//  EgeResultsSelectionViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit
class EgeResultsSelectionViewController: UIViewController, LoadableScreen, EgeResultsSelectionViewControllerProtocol {
    var message1: String!
    
    var message2: String!
    
    var loader: UIView?
    
    
    var presenter: EgeResultsSelectionPresenterProtocol!

    private var currentSubject: Int = 0
    var subjects: [String] = []
    private var hasDuplets = false
    
    private var subjectViews: [EgeResultsSelector] = []
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var TopViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subjectsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var subjectsView: UIStackView!
    @IBOutlet weak var addChildButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func addSubject() {
        self.addChildButton.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
            self.addChildButton.isUserInteractionEnabled = true
        })
        
        addSubjectView(startPos: currentSubject % subjects.count)
        currentSubject += 1
        self.view.layoutIfNeeded()

        updateScrollViewHeight()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        if subjectsView.subviews.count > 3 {
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height - 20)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
        if subjectsView.subviews.count == 15 {
            addChildButton?.isHidden = true
        }
        self.view.layoutIfNeeded()
    }
    
    @IBAction func skipRegistration() {
        let alert = UIAlertController(title: "Пропустить регистрацию?", message: "Всегда можно уточнить данные в настройках.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Пропустить", style: .destructive, handler: {_ in
            self.presenter?.presentSkipScreen()
        }))

        self.present(alert, animated: true)
    }
    
    @IBAction func nextScreen() {
        let isFilled = checkIfSubjectsFilled()
        showWarningIfNeeded(needScoreWarning: true)
        if hasDuplets || !isFilled {
            for subject in subjectViews {
                subject.shouldFill = true
            }
        } else {
            let subjects = subjectViews.map {element in
                return SubjectDetails(id: element.subjectPicker.selectedRow(inComponent: 0), score: Int(element.score.text ?? "-1") ?? -1)
            }
            self.presenter?.presentNextScreen(subjects: subjects)
        }
    }
    
    private func checkIfSubjectsFilled() -> Bool {
        
        for subject in subjectViews {
            if subject.score.text!.isEmpty {
                return false
            }
        }
        return true
    }
    
    private func addSubjectView(startPos: Int = 8) {
        let subject = EgeResultsSelector()
        subject.actionDispatcher = self
        subjectViews.append(subject)
        subject.subjects = subjects
        subject.startPosition = startPos
        subject.translatesAutoresizingMaskIntoConstraints = false
        
        subjectsView?.addArrangedSubview(subject)

        
        let leadingConstraint = NSLayoutConstraint(item: subject, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subjectsView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: subject, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subjectsView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: subject, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 58)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    private func updateScrollViewHeight() {
        let subjectCount = subjectsView.subviews.count
        
        switch subjectCount {
        case 0:
            subjectsViewHeightConstraint.constant = 0
        case 1:
            subjectsViewHeightConstraint.constant = 58
        case 2:
            subjectsViewHeightConstraint.constant = 58 * 2 + 20
        case 3:
            subjectsViewHeightConstraint.constant = 58 * 3 + 20 * 2
        default:
            subjectsViewHeightConstraint.constant = 58 * 3 + 20 * 3 + 6
        }
    }
    
    final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    final override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        addSubjectView(startPos: currentSubject % subjects.count)
        currentSubject += 1
        addSubjectView(startPos: currentSubject % subjects.count)
        currentSubject += 1
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        setupScrollView()
        updateScrollViewHeight()
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if heightConstraint.constant == 0 {
                heightConstraint.constant = keyboardSize.height - view.safeAreaInsets.bottom
                TopViewHeightConstraint.constant = 0
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if heightConstraint.constant != 0 {
            TopViewHeightConstraint.constant = 136
            heightConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    final override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    private func setupScrollView() {
        scrollView.canCancelContentTouches = false
        view.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
}

extension EgeResultsSelectionViewController: EgeResulsActionDispatcher {
    
    func didSelectRow() {
        showWarningIfNeeded()
    }

    private func highlightSubjects() {
        var rows: [Int] = []
        var hasDupletsNow: Bool = false
        
        for picker in subjectViews {
            let row = picker.subjectPicker.selectedRow(inComponent: 0)
            if rows.contains(row) {
                picker.isError = true
                hasDupletsNow = true
                hasDuplets = true
                picker.forbiddenRow = row
            } else {
                rows.append(row)
                picker.isError = false
            }
        }
        
        if !hasDupletsNow {
            hasDuplets = false
        }
    }
    
    private func showWarningIfNeeded(needScoreWarning: Bool = false) {
        
        let isFilled = checkIfSubjectsFilled()
        highlightSubjects()
        if hasDuplets && !isFilled && needScoreWarning {
            errorLabel.text = "Предметы не должны повторяться, нужно указать баллы"
        } else if hasDuplets {
            errorLabel.text = "Предметы не должны повторяться"
        } else if !isFilled && needScoreWarning {
            errorLabel.text = "Нужно указать баллы"
        } else {
            errorLabel.text = ""
        }
    }
    
    func tappedDelete(view: EgeResultsSelector) {
        subjectViews = subjectViews.filter { $0 != view }
        view.removeFromSuperview()
        
        updateScrollViewHeight()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        showWarningIfNeeded()
        
        if currentSubject > 0 {
            currentSubject -= 1
        }
        addChildButton.isHidden = false
    }
}
