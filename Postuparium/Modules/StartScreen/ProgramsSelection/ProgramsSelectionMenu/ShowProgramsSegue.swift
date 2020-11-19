//
//  ShowProgramsSegue.swift
//  Postuparium
//
//  Created by Михаил on 17.11.2020.
//

import UIKit

class ShowProgramsSegue: UIStoryboardSegue {

    override func perform() {
        
        let firstVCView = self.source.view! as UIView
        let secondVCView = self.destination.view! as UIView
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
     
        secondVCView.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        
//        let window = UIApplication.window
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
//            firstVCView.frame = firstVCView.frame.offsetBy(dx: 0.0, dy: -screenHeight)
            secondVCView.frame = secondVCView.frame.offsetBy(dx: 0.0, dy: -screenHeight)
     
            }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                            animated: false,
                            completion: nil)
        }
        
    }
    
}
