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
    
    // iterate through array of views in variadic parameter and adding individual subviews
    public func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
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
    
//    public func setBorderWidth(_ amount: CGFloat) {
//        let field = UIView.textField.layer.masksToBounds = true
//        field.layer.borderWidth = 1.5
//        field.layer.borderColor = UIColor.secondaryLabel.cgColor
//    }
}
