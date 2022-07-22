//
//  Extension.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - UIVIEW
    
    public var width: CGFloat {
        return frame.size.width
    }
    public var height: CGFloat {
        return frame.size.height
    }
    public var top: CGFloat {
        return frame.origin.y
    }
    public var bottom: CGFloat {
        return top + height
    }
    public var left: CGFloat {
        return frame.origin.x
    }
    public var right: CGFloat {
        return left + width
    }
    
    //MARK: - Add Subviews
    //iterate array of views in variadic parameter and adding individual subviews
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    //MARK: - Animate button after tap
    public func showAnimation(_ completionBlock: @escaping () -> Void) {
        //During animation, user interactions are temporarily disabled for all views involved in the animation
        isUserInteractionEnabled = false //ignore user interactions (touch, press)
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in // completion handler closure for UIView.animate
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }

    //MARK: - Shake TextField
    //Shake Textfield when user enters incorrect details
    public func animateInvalidLogin() {
//        isUserInteractionEnabled = false
        
        //option 1 Arcade Code Youtube
//        let animation = CAKeyframeAnimation() //animation type
//        animation.keyPath = "position.x" //static identifier for specific animation type
//        animation.values = [0, 10, -10, 10, 0] // positions of x coord. when content shakes
//        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1] // animation timing
//        animation.duration = 0.5
//        animation.isAdditive = true
        
        //option 2
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.translation.x"
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear) // timing pace of animation
        animation.duration = 0.6
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - UITEXTFIELD

extension UITextField {
    
    public func setLeftPaddingPoints(_ amount: CGFloat){ //the width of the left view is the padding before textfield contents
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = padding
        self.leftViewMode = .always
    }
}

//MARK: - STRING
extension String {
    // Avoid problems when registering users with @ or . on firebase
    public func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

//MARK: - VIEWCONTROLLER
extension UIViewController {
    //Dismiss contoller when you tap outside its  area
    @objc func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
