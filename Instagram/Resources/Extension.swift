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
    
    //MARK: - iterate array of views in variadic parameter and adding individual subviews
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    //MARK: - animate button after tap
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
}



// MARK: - UITEXTFIELD

extension UITextField {
    
    public func setLeftPaddingPoints(_ amount: CGFloat){
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = padding
        self.leftViewMode = .always
    }
}

//MARK: - STRING
extension String {
    // Avoid problems when registering users with @ or . on firebase
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
