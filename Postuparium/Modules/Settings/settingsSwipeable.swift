//
//  SwipeableViewController.swift
//  Postuparium
//
//  Created by Михаил on 20.11.2020.
//
import UIKit

class SSwipeableViewController: USwipeableViewController {
    
    var scardViewController: CardViewControllerProtocol! {
        didSet {
            setupCard()
        }
    }
    @IBInspectable var scardHeight:CGFloat = 716
    @IBInspectable var scardHandleAreaHeight:CGFloat = 0
    @IBInspectable var sduration = 0.3
    
    func showSCard() {
        animateTransitionIfNeeded(state: .expanded, duration: sduration)
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
        self.addChild(scardViewController)
        self.view.addSubview(scardViewController.view)
        
        scardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - scardHandleAreaHeight, width: self.view.bounds.width, height: scardHeight)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.shandleCardPan(recognizer:)))
//        panGestureRecognizer.cancelsTouchesInView = false
        scardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
        
    }

    private var smaxFraction: CGFloat = 0
    @objc private func shandleCardPan (recognizer:UIPanGestureRecognizer) {
        scardViewController.view.endEditing(true)
        let translation = recognizer.translation(in: self.scardViewController.handleArea)
        let fractionComplete = abs(translation.y) / scardHeight
    
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: .collapsed, duration: sduration)
        case .changed:
            if translation.y > 0{
                updateInteractiveTransition(fractionCompleted: fractionComplete)
            }
        case .ended:
            if translation.y < 0{
                cancelTransition()
            }
            if (fractionComplete < smaxFraction * 0.95 || smaxFraction < 0.1 ){
                cancelTransition()
                animateTransitionIfNeeded(state: .expanded, duration: sduration / 3)
            } else {
                continueInteractiveTransition()
            }
        default:
            break
        }
        smaxFraction = max(smaxFraction, fractionComplete)
    }
    
    private func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {

        if uRunningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
                switch state {
                case .expanded:
                    self.scardViewController.view.frame.origin.y = self.view.frame.height - self.scardHeight
                case .collapsed:
                    self.scardViewController.view.frame.origin.y = self.view.frame.height - self.scardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.smaxFraction = 0
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
            self.smaxFraction = 0
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
