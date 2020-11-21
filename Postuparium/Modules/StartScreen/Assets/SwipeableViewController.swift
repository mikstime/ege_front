//
//  SwipeableViewController.swift
//  Postuparium
//
//  Created by Михаил on 20.11.2020.
//

import UIKit
protocol CardViewControllerProtocol: UIViewController {
    var handleArea: UIView! { get set }
}
class SwipeableViewController: UIViewController {
    
    var cardViewController:CardViewControllerProtocol! {
        didSet {
            setupCard()
        }
    }
    
    @IBInspectable var cardHeight:CGFloat = 450
    @IBInspectable var cardHeightMaxMargin:CGFloat = 200
    @IBInspectable var cardHandleAreaHeight:CGFloat = 0
    @IBInspectable var duration = 0.3
    
    func showCard() {
        animateTransitionIfNeeded(state: .expanded, duration: duration)
    }
    
    private enum CardState {
        case expanded
        case collapsed
    }
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }
    private func setupCard() {
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight + cardHeightMaxMargin)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
//        panGestureRecognizer.cancelsTouchesInView = false
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    var maxFraction: CGFloat = 0
    @objc private func handleCardPan (recognizer:UIPanGestureRecognizer) {
        cardViewController.view.endEditing(true)
        let translation = recognizer.translation(in: self.cardViewController.handleArea)
        let fractionComplete = abs(translation.y) / cardHeight
    
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: .collapsed, duration: duration)
        case .changed:
            if translation.y > 0{
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            }
        case .ended:
            if translation.y < 0{
                cancelTransition()
            }
            if (fractionComplete < maxFraction * 0.95 || maxFraction < 0.1 ){
                cancelTransition()
                animateTransitionIfNeeded(state: .expanded, duration: duration / 3)
            } else {
                continueInteractiveTransition()
            }
        default:
            break
        }
        maxFraction = max(maxFraction, fractionComplete)
    }
    
    private func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {

        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.maxFraction = 0
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
        }
    }
    
    private func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func cancelTransition() {
        for animator in runningAnimations {
            self.maxFraction = 0
            animationProgressWhenInterrupted = animator.fractionComplete
            animator.stopAnimation(true)
//            animator.isInterruptible = true
//            animator.isReversed = true
        }
        self.runningAnimations.removeAll()
    }
    
    private func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
