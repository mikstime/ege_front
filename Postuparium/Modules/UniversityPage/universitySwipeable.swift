//
//  SwipeableViewController.swift
//  Postuparium
//
//  Created by Михаил on 20.11.2020.
//
import UIKit

class USwipeableViewController: SwipeableMenuViewController {
    
    var ucardViewController: CardViewControllerProtocol! {
        didSet {
            setupCard()
        }
    }
    @IBInspectable var ucardHeight:CGFloat = 716
    @IBInspectable var ucardHandleAreaHeight:CGFloat = 0
    @IBInspectable var uduration = 0.3
    
    func showUCard() {
        animateTransitionIfNeeded(state: .expanded, duration: uduration)
    }
    
    private enum CardState {
        case expanded
        case collapsed
    }
    
    private var uRunningAnimations = [UIViewPropertyAnimator]()
    private var uAnimationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
    }
    private func setupCard() {
        self.addChild(ucardViewController)
        self.view.addSubview(ucardViewController.view)
        
        ucardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - ucardHandleAreaHeight, width: self.view.bounds.width, height: ucardHeight)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.uhandleCardPan(recognizer:)))
//        panGestureRecognizer.cancelsTouchesInView = false
        ucardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    private var umaxFraction: CGFloat = 0
    @objc private func uhandleCardPan (recognizer:UIPanGestureRecognizer) {
        ucardViewController.view.endEditing(true)
        let translation = recognizer.translation(in: self.ucardViewController.handleArea)
        let fractionComplete = abs(translation.y) / ucardHeight
    
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: .collapsed, duration: uduration)
        case .changed:
            if translation.y > 0{
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            }
        case .ended:
            if translation.y < 0{
                cancelTransition()
            }
            if (fractionComplete < umaxFraction * 0.95 || umaxFraction < 0.1 ){
                cancelTransition()
                animateTransitionIfNeeded(state: .expanded, duration: uduration / 3)
            } else {
                continueInteractiveTransition()
            }
        default:
            break
        }
        umaxFraction = max(umaxFraction, fractionComplete)
    }
    
    private func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {

        if uRunningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
                switch state {
                case .expanded:
                    self.ucardViewController.view.frame.origin.y = self.view.frame.height - self.ucardHeight
                case .collapsed:
                    self.ucardViewController.view.frame.origin.y = self.view.frame.height - self.ucardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.umaxFraction = 0
                self.uRunningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            uRunningAnimations.append(frameAnimator)
            
        }
    }
    
    private func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if uRunningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in uRunningAnimations {
            animator.pauseAnimation()
            uAnimationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func cancelTransition() {
        for animator in uRunningAnimations {
            self.umaxFraction = 0
            uAnimationProgressWhenInterrupted = animator.fractionComplete
            animator.stopAnimation(true)
        }
        self.uRunningAnimations.removeAll()
    }
    
    private func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in uRunningAnimations {
            animator.fractionComplete = fractionCompleted + uAnimationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition (){
        for animator in uRunningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}
