//
//  HalfModalPresentationController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 19.12.2020.
//

import UIKit

enum ModalScaleState {
    case adjustedOnce
    case normal
}

class HalfModalPresentationController : UIPresentationController {
    var isMaximized: Bool = false
    
    var _dimmingView: UIView?
    var panGestureRecognizer: UIPanGestureRecognizer
    var direction: CGFloat = 0
    var state: ModalScaleState = .normal
    var dimmingView: UIView {
        if let dimmedView = _dimmingView {
            return dimmedView
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height))
        
        _dimmingView = view
        
        return view
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.panGestureRecognizer = UIPanGestureRecognizer()
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        panGestureRecognizer.addTarget(self, action: #selector(onPan(pan:)))
        presentedViewController.view.addGestureRecognizer(panGestureRecognizer)
        
        presentedViewController.navigationController?.isNavigationBarHidden = true
    }

    
    @objc func onPan(pan: UIPanGestureRecognizer) -> Void {
        let endPoint = pan.translation(in: pan.view?.superview)
        print("onPan")
        switch pan.state {
        case .began:
            print("began")
            presentedView!.frame.size.height = containerView!.frame.height
        case .changed:
            print("changed")
            let velocity = pan.velocity(in: pan.view?.superview)
            print(velocity.y)
            switch state {
            case .normal:
                print("normal")
                presentedView!.frame.origin.y = endPoint.y + containerView!.frame.height / 2
            case .adjustedOnce:
                print("adjusted")
                presentedView!.frame.origin.y = endPoint.y
            }
            direction = velocity.y
            
            break
        case .ended:
            if direction < 0 {
                changeScale(to: .adjustedOnce)
            } else {
                if state == .adjustedOnce {
                    changeScale(to: .normal)
                } else {
                    presentedViewController.dismiss(animated: true, completion: nil)
                }
            }
            
            print("finished transition")
            
            break
        default:
            print("pizdets")
            break
        }
    }
    
    func changeScale(to state: ModalScaleState) {
        if let presentedView = presentedView, let containerView = self.containerView {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { () -> Void in
                presentedView.frame = containerView.frame
                let containerFrame = containerView.frame
                let halfFrame = CGRect(origin: CGPoint(x: 0, y: containerFrame.height / 2),
                                       size: CGSize(width: containerFrame.width, height: containerFrame.height / 2))
                let frame = state == .adjustedOnce ? containerView.frame : halfFrame
                
                presentedView.frame = frame
                
                if let navController = self.presentedViewController as? UINavigationController {
                    self.isMaximized = true
                    
                    navController.setNeedsStatusBarAppearanceUpdate()
                    
                    // Force the navigation bar to update its size
                    navController.isNavigationBarHidden = true
//                    navController.isNavigationBarHidden = false
                }
            }, completion: { (isFinished) in
                self.state = state
            })
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: containerView!.bounds.height / 2, width: containerView!.bounds.width, height: containerView!.bounds.height / 2)
    }
    
    override func presentationTransitionWillBegin() {
        let dimmedView = dimmingView
        
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            
            dimmedView.alpha = 0
            containerView.addSubview(dimmedView)
            dimmedView.addSubview(presentedViewController.view)
            
            coordinator.animate(alongsideTransition: { (context) -> Void in
                dimmedView.alpha = 1
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            
            coordinator.animate(alongsideTransition: { (context) -> Void in
                self.dimmingView.alpha = 0
                self.presentingViewController.view.transform = CGAffineTransform.identity
            }, completion: { (completed) -> Void in
                print("done dismiss animation")
            })
            
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print("dismissal did end: \(completed)")
        
        if completed {
            dimmingView.removeFromSuperview()
            _dimmingView = nil
            
            isMaximized = false
        }
    }
}

protocol HalfModalPresentable {
    var id: Int { get set };
}

extension HalfModalPresentable where Self: UIViewController {
    func maximizeToFullScreen() -> Void {
        print("in maximazed")
        if let presetation = navigationController?.presentationController as? HalfModalPresentationController {
            presetation.changeScale(to: .adjustedOnce)
            print("in maximazed")
        }
    }
}

extension HalfModalPresentable where Self: UINavigationController {
    func isHalfModalMaximized() -> Bool {
        print("in half")
        if let presentationController = presentationController as? HalfModalPresentationController {
            print("isHaldModalMax pos")
            return presentationController.isMaximized
        }
        print("isHaldModalMax false")
        return false
    }
}
