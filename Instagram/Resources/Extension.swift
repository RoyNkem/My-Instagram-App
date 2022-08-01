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
    //Shake Textfield when user enters incorrect details or empty textfield
    public func animateInvalidLogin() {
        
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

//MARK: - UIAlertController Actions
extension UIAlertController {
    //iterate array of actions in variadic parameter and adding individual actions to alertVC
    public func addActions(_ actions: UIAlertAction...) {
        for action in actions {
            addAction(action)
        }
    }
}

//MARK: - UISegmentedControl Actions
//extension UISegmentedControl {
//
//    func removeBorder(){
//
//        self.tintColor = UIColor.clear
//        self.backgroundColor = UIColor.clear
//        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.stavkrugDarkBlue], for: .selected)
//        self.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
//        if #available(iOS 13.0, *) {
//            self.selectedSegmentTintColor = UIColor.clear
//        }
//
//    }
//
//    func setupSegment() {
//        self.removeBorder()
//        let segmentUnderlineWidth: CGFloat = self.bounds.width
//        let segmentUnderlineHeight: CGFloat = 2.0
//        let segmentUnderlineXPosition = self.bounds.minX
//        let segmentUnderLineYPosition = self.bounds.size.height - 1.0
//        let segmentUnderlineFrame = CGRect(x: segmentUnderlineXPosition, y: segmentUnderLineYPosition, width: segmentUnderlineWidth, height: segmentUnderlineHeight)
//        let segmentUnderline = UIView(frame: segmentUnderlineFrame)
//        segmentUnderline.backgroundColor = UIColor.clear
//
//        self.addSubview(segmentUnderline)
//        self.addUnderlineForSelectedSegment()
//    }
//
//    func addUnderlineForSelectedSegment(){
//
//        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
//        let underlineHeight: CGFloat = 2.0
//        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
//        let underLineYPosition = self.bounds.size.height - 1.0
//        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
//        let underline = UIView(frame: underlineFrame)
//        underline.backgroundColor = UIColor.stavkrugDarkBlue
//        underline.tag = 1
//        self.addSubview(underline)
//
//
//    }
//
//    func changeUnderlinePosition(){
//        guard let underline = self.viewWithTag(1) else {return}
//        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
//        underline.frame.origin.x = underlineFinalXPosition
//
//    }
//}

extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.secondarySystemFill.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default) // background image for segmented controls will be white

        let dividerImage = UIImage.getColoredRectImageWith(color: UIColor.label.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default) // divider image will be white
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }

    //add view (underline) to selected segments
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments) //width for selected segment
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.secondaryLabel
        underline.tag = 1 // An Int used to identify views object
        self.addSubview(underline)
    }

    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return} //returns view created above
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0) //create graphics  context with options: size in points, opaque bool and scale
        let graphicsContext = UIGraphicsGetCurrentContext() //returns current context created above
        graphicsContext?.setFillColor(color) // set fill color using parameter pass from higher func.
        
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle) //paints the specified area with color passed
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext() //return image from graphics context above
        
        UIGraphicsEndImageContext() //removes current context from top of stack to clean drawing environment started above
        return rectangleImage! // we have an image from the content of our graphics context with the size we pass in and filled with the color
    }
}
