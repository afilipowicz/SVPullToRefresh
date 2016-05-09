//
//  CinoSpinner.swift
//  Flashpick-iOS
//
//  Created by Marcin Jackowski on 08/03/16.
//  Copyright © 2016 Paweł Sternik. All rights reserved.
//

import Foundation
import UIKit

@objc public class CustomRefreshControl: UIRefreshControl {
    
    public var hidesWhenStopped = false
    private static let spinnerHeight: CGFloat = 50
    private var cinoSpinner = CinoSpinner(frame: CGRect(x: 0, y: 0, width: CustomRefreshControl.spinnerHeight, height: CustomRefreshControl.spinnerHeight))

    public func setup() {
        self.tintColor = .clearColor()
        self.addSubview(cinoSpinner)
        setConstraintForSpinner()
    }
    
    private func setConstraintForSpinner() {
        self.addConstraints(cinoSpinner.centerInParentView(self))
        self.addConstraints(cinoSpinner.setDimensionConstraints(width: CustomRefreshControl.spinnerHeight, height: CustomRefreshControl.spinnerHeight))
        cinoSpinner.setup(alpha: 0.0)
    }

    public func changeSpinnerAlpha(contentOffset: CGFloat) {
        let absoluteValue = (abs(contentOffset) / 100.0)
        cinoSpinner.alpha = absoluteValue
    }
    
    public func refreshAnimation() {
        cinoSpinner.startAnimation()
    }
    
    public func startRefreshing() {
        UIView.animateWithDuration(0.4) {
            self.cinoSpinner.alpha = 1.0
        }
    }
    
    public func stopRefreshing() {
        dispatch_async(dispatch_get_main_queue()) {
            self.endRefreshing()
            if self.hidesWhenStopped {
                self.cinoSpinner.alpha = 0.0
            }
        }
    }
}

extension UIView {
    private func centerInParentView(parentView: UIView) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(
            item: self,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: parentView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        let verticalConstraint = NSLayoutConstraint(
            item: self,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: parentView,
            attribute: .CenterY,
            multiplier: 1,
            constant: 0.0)
        
        return [horizontalConstraint, verticalConstraint]
    }
    
    private func setDimensionConstraints(width width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: width)
        
        let heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: height)
        
        return [widthConstraint, heightConstraint]
    }
}
