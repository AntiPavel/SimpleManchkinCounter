//
//  UINavigationExtension.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

public extension UINavigationController {
    
    /**
     Pop current view controller to previous view controller.
     */
    func popLikeModal() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: nil)
        self.popViewController(animated: false)
    }
    func popLikeBackModal() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.layer.add(transition, forKey: nil)
        self.popViewController(animated: false)
    }
    
    /**
     Push a new view controller on the view controllers's stack.
     - parameter vc:       view controller to push.
     */
    func pushLikeModal(viewController vc: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: nil)
        self.pushViewController(vc, animated: false)
    }
    
    /**
     thransition for the current view controller.
     
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    private func addTransition(transitionType type: String = convertFromCATransitionType(CATransitionType.fade), duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = convertToCATransitionType(type)
        self.view.layer.add(transition, forKey: nil)
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromCATransitionType(_ input: CATransitionType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}
