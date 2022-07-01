//
//  Extension.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
    // iterate through array of views in variadic parameter and adding individual subviews 
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
