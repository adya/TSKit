import UIKit
import TSKit_Core

@IBDesignable
class GradientTableView: UITableView {
    
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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundView = TSKit_Core.transform(GradientView()) {
            $0.startColor = startColor
            $0.endColor = endColor
            $0.angle = angle
        }
    }
    
    private func updateGradient() {
        TSKit_Core.transform(self.backgroundView as? GradientView) {
            $0?.startColor = startColor
            $0?.endColor = endColor
            $0?.angle = angle
        }
    }
}
