import Foundation
import UIKit

@objc public class CustomRefreshControl: UIRefreshControl {
    
    public var hidesWhenStopped = false
    private var cinoSpinner = CinoSpinner()
    
    public func setup() {
        self.tintColor = .clearColor()
        self.addSubview(cinoSpinner)
        setConstraintForSpinner()
    }
    
    private func setConstraintForSpinner() {
        self.addConstraints(cinoSpinner.centerInParentView(self))
        self.addConstraints(cinoSpinner.setDimensionConstraints(width: CinoSpinner.dimension, height: CinoSpinner.dimension))
        cinoSpinner.setup(alpha: 0.0)
    }
    
    public func changeSpinnerAlpha(contentOffset: CGFloat) {
        let absoluteValue = (abs(contentOffset) / 100.0)
        cinoSpinner.alpha = absoluteValue
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        if self.hidesWhenStopped {
            self.cinoSpinner.fade(CinoSpinner.FadeDirection.Out)
        }
    }
    
    public override func beginRefreshing() {
        super.beginRefreshing()
        cinoSpinner.fade(CinoSpinner.FadeDirection.In)
    }
    
    public func refreshAnimation() {
        cinoSpinner.startAnimation()
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
