//
//  EgeResultsSelectionViewContoller.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import UIKit

class EgeResultsSelectionViewController: UIViewController, EgeResultsSelectionViewControllerProtocol {
    
    var presenter: EgeResultsSelectionPresenterProtocol!
    var spinner: UIView!
    
    func startLoading() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.systemBackground
        let ai = LoadingView()
        
        DispatchQueue.main.async {
            self.view.addSubview(spinnerView)
            spinnerView.addSubview(ai)
            
            ai.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: ai, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: spinnerView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
            ai.showLoading()
        }
        
        spinner = spinnerView
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.spinner?.removeFromSuperview()
            self.spinner = nil
        }
    }
    
    var currentSubject: Int = 0
    var subjects: [String] = []
    var hasDuplets = false
    
    var subjectViews: [EgeResultsSelector] = []
    
    var stackView = UIStackView()
    
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
    
    func checkIfSubjectsFilled() -> Bool {
        
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
    
    func updateScrollViewHeight() {
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
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
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
        
        setupScrollView()
        updateScrollViewHeight()
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
    
    final override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    final override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    func setupScrollView() {
        scrollView.canCancelContentTouches = false
        view.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
}

extension EgeResultsSelectionViewController: EgeResulsActionDispatcher {
    
    func didSelectRow() {
        showWarningIfNeeded()
    }

    func highlightSubjects() {
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
    
    func showWarningIfNeeded(needScoreWarning: Bool = false) {
        
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
        showWarningIfNeeded()
        
        if currentSubject > 0 {
            currentSubject -= 1
        }
        addChildButton.isHidden = false
    }
}
