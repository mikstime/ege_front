//
//  NibExtension.swift
//  Postuparium
//
//  Created by Михаил on 13.11.2020.
//

import Foundation
import UIKit


extension UIView
{
    public func attachViewWithConstraints(_ view:UIView)
    {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutAttachAll(to: self)
    }

    @discardableResult
    public func viewLoadedFromNibAttached<T : UIView>(name:String) -> T? {
        guard let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?[0] as? T else {
            return nil
        }
        attachViewWithConstraints(view)
        return view
    }

    public func layoutAttachAll(to childView:UIView)
    {
        var constraints = [NSLayoutConstraint]()

        childView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: childView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))

        childView.addConstraints(constraints)
    }
    
}


extension UIView {

    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {    // 3
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)     // 4
        contentView.translatesAutoresizingMaskIntoConstraints = false   // 5
        contentView.layoutAttachAll(to: self)   // 6
        return contentView   // 7
    }
}
