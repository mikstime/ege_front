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
    
    // Must be set
    var cardViewController: CardViewControllerProtocol! {
        didSet {
            setupCard()
        }
    }
    
    @IBInspectable var cardHeight:CGFloat = 450
    @IBInspectable var cardExpansion:CGFloat = 200
    @IBInspectable var cardHeightMaxMargin:CGFloat = 200
    @IBInspectable var cardHandleAreaHeight:CGFloat = 200
    @IBInspectable var duration = 0.3
    
    private var maxFraction: CGFloat = 0
    private var fractionComplete: CGFloat = 0
    
    func showCard() {
        animateTransitionIfNeeded(state: .expanded, duration: duration)
    }
    
    private enum CardState {
        case expanded
        case collapsed
        case fully_expanded
    }
    
    private enum Direction {
        case up
        case down
        case no
    }
    private var cardState = CardState.collapsed
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
    private var direction = Direction.no
    @objc private func handleCardPan (recognizer:UIPanGestureRecognizer) {
        cardViewController.view.endEditing(true)
        let translation = recognizer.translation(in: self.cardViewController.handleArea)
        fractionComplete = abs(translation.y) / cardHeight
    
        switch recognizer.state {
        case .began:
            if cardState == .collapsed {
                startInteractiveTransition(state: .expanded, duration: duration)
            }
            if cardState == .expanded {
                if translation.y > 0 {
                    direction = .up
                    startInteractiveTransition(state: .fully_expanded, duration: duration)
                } else {
                    direction = .down
                    startInteractiveTransition(state: .collapsed, duration: duration)
                }
            }
            if cardState == .fully_expanded {
                startInteractiveTransition(state: .expanded, duration: duration)
            }
        case .changed:
            if cardState == .collapsed {
                if translation.y < 0{
                    updateInteractiveTransition(fractionCompleted: fractionComplete)
                }
            }
            if cardState == .expanded {
                if translation.y < 0 {
                    if direction == .up {
                        updateInteractiveTransition(fractionCompleted: fractionComplete)
                    } else {
                        direction = .down
                        cancelTransition()
                        startInteractiveTransition(state: .expanded, duration: duration)
                    }
                }
                if translation.y > 0 {
                    if direction == .down {
                        updateInteractiveTransition(fractionCompleted: fractionComplete)
                    } else {
                        direction = .up
                        cancelTransition()
                        startInteractiveTransition(state: .fully_expanded, duration: duration)
                    }
                    
                }
            }
            if cardState == .fully_expanded {
                if translation.y > 0{
                    updateInteractiveTransition(fractionCompleted: fractionComplete)
                }
            }
        case .ended:
            if cardState == .collapsed {
                if translation.y > 0{
                    cancelTransition()
                }
                if (fractionComplete < maxFraction * 0.95 || maxFraction < 0.1 ){
                    cancelTransition()
                    animateTransitionIfNeeded(state: .collapsed, duration: duration / 3)
                } else {
                    continueInteractiveTransition()
                }
            }
            if cardState == .expanded {
                if translation.y < 0{
                    cancelTransition()
                }
                if (fractionComplete < maxFraction * 0.95 || maxFraction < 0.1 ){
                    cancelTransition()
                    animateTransitionIfNeeded(state: .expanded, duration: duration / 3)
                } else {
                    continueInteractiveTransition()
                }
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
                case .fully_expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight - self.cardExpansion
                }
            }
            
            frameAnimator.addCompletion { _ in
                if (!(self.fractionComplete < self.maxFraction * 0.95 || self.maxFraction < 0.1) ){
                    self.cardState = self.direction == .no ? self.cardState == .expanded ? .collapsed : .expanded : self.direction == .up ? .fully_expanded : .expanded
                }
                self.maxFraction = 0
                self.fractionComplete = 0
                self.direction = .no
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

extension SwipeableViewController {
    
}
