import Foundation
import UIKit

@objc public class CinoSpinner: UIView {
    
    public enum FadeDirection {
        case In
        case Out
    }
    
    public static let dimension: CGFloat = 50.0
    
    private var positionYAnimation: CABasicAnimation?
    private var scaleAnimation: CABasicAnimation?
    private var moveAnimation: CAKeyframeAnimation?
    private var dot = CALayer()
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: CinoSpinner.dimension, height: CinoSpinner.dimension)))
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup(alpha: 1.0)
    }
    
    public func setup(alpha alpha: CGFloat) {
        self.alpha = alpha
        let dotNum: CGFloat = 7.0
        let diameter: CGFloat = self.frame.size.width / 10.0
        let duration: CFTimeInterval = 2.5
        
        let frame = CGRect(
            x: (layer.bounds.width - diameter) / 2.0 + diameter * 2.0,
            y: (layer.bounds.height - diameter) / 2.0,
            width: diameter,
            height: diameter
        )
        
        dot.backgroundColor = UIColor(red: 56.0 / 255.0, green: 160.0 / 255.0, blue: 255.0 / 255.00, alpha: 1.0).CGColor
        dot.cornerRadius = diameter / 2.0
        dot.frame = frame
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = layer.bounds
        replicatorLayer.instanceCount = Int(dotNum)
        replicatorLayer.instanceDelay = 0.4
        
        let angle = 2.0 * CGFloat(M_PI) / CGFloat(replicatorLayer.instanceCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.3, 0.0, 1.0)
        
        layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(dot)
        
        positionYAnimation = CABasicAnimation(keyPath: "position.y")
        scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        moveAnimation = CAKeyframeAnimation(keyPath: "position")
        
        guard let positionYAnimation = positionYAnimation, scaleAnimation = scaleAnimation, moveAnimation = moveAnimation else { return }
        
        positionYAnimation.toValue = frame.origin.y + diameter * 4.0
        positionYAnimation.duration = duration / 3.0
        positionYAnimation.autoreverses = true
        positionYAnimation.repeatCount = .infinity
        positionYAnimation.removedOnCompletion = false
        positionYAnimation.fillMode = kCAFillModeForwards
        positionYAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        scaleAnimation.toValue = 0.5
        scaleAnimation.duration = duration
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.removedOnCompletion = false
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        
        moveAnimation.beginTime = 1.0
        moveAnimation.path = getPath()
        moveAnimation.duration = duration
        moveAnimation.repeatCount = .infinity
        moveAnimation.removedOnCompletion = false
        moveAnimation.fillMode = kCAFillModeForwards
        moveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        startAnimation()
    }
    
    private func getPath() -> CGPath {
        let radius = CGRectGetWidth(self.frame) / 3.0
        let path = CGPathCreateMutable()
        
        CGPathAddArc(path, nil, CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0, radius, CGFloat(-M_PI_2), CGFloat(M_PI_2 * 3.0), false)
        return path
    }
    
    public func startAnimation() {
        dot.removeAllAnimations()
        guard let positionYAnimation = positionYAnimation, scaleAnimation = scaleAnimation, moveAnimation = moveAnimation else { return }
        
        dot.addAnimation(positionYAnimation, forKey: "positionYAnimation")
        dot.addAnimation(scaleAnimation, forKey: "scaleAnimation")
        dot.addAnimation(moveAnimation, forKey: "moveAnimation")
    }
    
    public func fade(direction: FadeDirection) {
        dispatch_async(dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.4) {
                self.alpha = direction == .In ? 1.0 : 0.0
            }
        }
    }
    
    /**
     To expose the underlying method to Objective-C
     
     - parameter direction: true - in; false - out
     */
    public func fade(direction: Bool) {
        fade(direction ? .In : .Out)
    }
}
