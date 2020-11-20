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
    @IBInspectable var cardHandleAreaHeight:CGFloat = 0
    @IBInspectable var duration = 0.3
    
    func showCard() {
        animateTransitionIfNeeded(state: nextState, duration: duration)
    }
    
    private enum CardState {
        case expanded
        case collapsed
    }
    
    private var cardVisible = false
    private var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
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
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        panGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.cancelsTouchesInView = false
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    @objc private func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            if !cardVisible {
                animateTransitionIfNeeded(state: nextState, duration: duration)
            }
        default:
            break
        }
    }
    var maxFraction: CGFloat = 0
    @objc private func handleCardPan (recognizer:UIPanGestureRecognizer) {
        cardViewController.view.endEditing(true)
        let translation = recognizer.translation(in: self.cardViewController.handleArea)
        var fractionComplete = translation.y / cardHeight
        fractionComplete = cardVisible ? fractionComplete : -fractionComplete
        
        switch recognizer.state {
        case .began:
            if (translation.y < 0 && cardVisible) || (translation.y > 0 && !cardVisible) {
                break
            }
            startInteractiveTransition(state: nextState, duration: duration)
        case .changed:
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            if (fractionComplete < maxFraction * 0.95 ){
                cancelTransition()
                animateTransitionIfNeeded(state: nextState == .collapsed ? .expanded : .collapsed, duration: duration / 3)
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
                self.cardVisible = !self.cardVisible
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
            animator.stopAnimation(true)
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
