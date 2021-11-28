import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable
    var startColor: UIColor = .white {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var endColor: UIColor = .white {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var angle: Float = 90 {
        didSet {
            updateGradient()
            setNeedsDisplay()
        }
    }
    
    private func updateGradient() {
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        let alpha: Float = angle / 360
        let startPointX = powf(sinf(2 * Float.pi * ((alpha + 0.75) / 2)), 2)
        let startPointY = powf(sinf(2 * Float.pi * ((alpha + 0) / 2)), 2)
        let endPointX = powf(sinf(2 * Float.pi * ((alpha + 0.25) / 2)), 2)
        let endPointY = powf(sinf(2 * Float.pi * ((alpha + 0.5) / 2)), 2)
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(endPointX),y: CGFloat(endPointY))
        gradientLayer.startPoint = CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
    }
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.masksToBounds = true
        updateGradient()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.masksToBounds = true
        updateGradient()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
