//
//  FlipStepper.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/23/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

class FlipStepper: UIControl {
    
    @objc @IBInspectable public var isActive: Bool = true
    
    private let topStepperImage: UIImage? = UIImage(named: "whiteTopCounterBackground")
    private let bottomStepperImage: UIImage? = UIImage(named: "whiteBottomCounterBackground")
    private let topStepperAnimationImage: UIImage? = UIImage(named: "topCounter")
    private let bottomHalfStepperAnimationImage: UIImage? = UIImage(named: "downCounter")
    
    private let topCounterImage: UIImage? = UIImage(named: "whiteTopCounterBackground")
    private let bottomCounterImage: UIImage? = UIImage(named: "whiteBottomCounterBackground")
    private let topAnimationCounterImage: UIImage? = UIImage(named: "topCounter")
    private let bottomAnimationCounterImage: UIImage? = UIImage(named: "downCounter")
    
    private var topStaticImage: UIImage? {
        guard isActive else {
            return topCounterImage
        }
        return topStepperImage
    }
    
    private var bottomStaticImage: UIImage? {
        guard isActive else {
            return bottomCounterImage
        }
        return bottomStepperImage
    }
    
    private var topAnimationImage: UIImage? {
        guard isActive else {
            return topAnimationCounterImage
        }
        return topStepperAnimationImage
    }
    
    private var bottomAnimationImage: UIImage? {
        guard isActive else {
            return bottomAnimationCounterImage
        }
        return bottomHalfStepperAnimationImage
    }
    
    private lazy var baseView: UIView = {
        let view = UIView(frame: self.bounds)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var topImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2))
        view.image = topStaticImage
        return view
    }()
    
    private lazy var bottomImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: self.bounds.height/2, width: self.bounds.width, height: self.bounds.height/2))
        view.image = bottomStaticImage
        return view
    }()
    
    var originalWidth: CGFloat!
    
    var longWidth: CGFloat {
        guard let width = originalWidth else { return self.bounds.width }
        return width * 1.35
    }
    
    @objc @IBInspectable public var value: Int = 99 {
        didSet {
            value = min(maxValue, max(minValue, value))
            if value < oldValue {
                addNewAnimation(param: (value, .Up))
            } else if value > oldValue {
                addNewAnimation(param: (value, .Down))
            } else {
                return
            }
            sendActions(for: .valueChanged)
            layoutSubviews()
        }
    }
    
    @objc @IBInspectable public var minValue: Int = 0 {
        didSet {
            value = min(maxValue, max(minValue, value))
        }
    }
    
    @objc @IBInspectable public var maxValue: Int = 999 {
        didSet {
            value = min(maxValue, max(minValue, value))
        }
    }
    
    @objc @IBInspectable public var stepValue: Int = 1
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = String(self.value)
        label.textColor = self.labelTextColor
        label.backgroundColor = .clear
        label.font = self.labelFont
        label.numberOfLines = 1
       // label.adjustsFontSizeToFitWidth = true
        //label.minimumScaleFactor = 0.5

        return label
    }()
    
    @objc @IBInspectable public var labelTextColor: UIColor = .black {
        didSet {
            label.textColor = labelTextColor
        }
    }

    @objc public var labelFont = UIFont(name: "MarkerFelt-Wide", size: 30) ?? UIFont.boldSystemFont(ofSize: 15) {
        didSet {
            label.font = labelFont
        }
    }
    
    lazy var topButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(FlipStepper.topButtonTouchDown), for: .touchDown)
        return button
    }()
    
    lazy var bottomButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: self.bounds.height/2, width: self.bounds.width, height: self.bounds.height/2))
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(FlipStepper.bottomButtonTouchDown), for: .touchDown)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(label)
        addSubview(baseView)
        addSubview(topButton)
        addSubview(bottomButton)
        
        originalWidth = self.bounds.width
        let height = CGFloat(self.bounds.height)
        label.font = self.labelFont.withSize(height * 0.6)
    }
    
    // Mark: layout
    public override func layoutSubviews() {
        let centerX = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        self.addConstraints([centerX, centerY])
    }
    
    private func resizeToLongWidth() {
        constraints.first { $0.firstAnchor == widthAnchor }?.isActive = false
        self.frame.size.width = longWidth
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: longWidth)
        self.addConstraints([width])
        self.layoutIfNeeded()
        topImageView.frame.size.width = self.frame.size.width
        bottomImageView.frame.size.width = self.frame.size.width
        baseView.frame.size.width = self.frame.size.width
    }
    
    private func resizeToShortWidth() {
        guard let originalWidth = originalWidth else { return }
        self.frame.size.width = originalWidth
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: originalWidth)
        self.addConstraints([width])
        self.layoutIfNeeded()
        topImageView.frame.size.width = self.frame.size.width
        bottomImageView.frame.size.width = self.frame.size.width
        baseView.frame.size.width = self.frame.size.width
    }
    
    // Mark: change value
    @objc func topButtonTouchDown(button: UIButton) {
        bottomButton.isEnabled = false
        increaseValue()
        bottomButton.isEnabled = true
    }
    
    @objc func bottomButtonTouchDown(button: UIButton) {
        topButton.isEnabled = false
        decreaseValue()
        topButton.isEnabled = true
    }
    
    func increaseValue() {
        value += stepValue
    }
    
    func decreaseValue() {
        value -= stepValue
    }
    
    // MARK: animation
    
    enum FlipAnimationDirection {
        case Up, Down
    }
    
    private var isAnimationStarted = false
    
    var animations: Array<(Int, FlipAnimationDirection)> = [] {
        didSet {

            guard animations.count > 0  else {
                self.label.text = String(self.value)
                if value <= 99, self.frame.width > self.originalWidth {
                    delay(0.3, closure: {
                        self.resizeToShortWidth()
                    })
                }
                return
            }
            guard !isAnimationStarted  else { return }
            guard let value = animations.first?.0  else { return }
            guard let direction = animations.first?.1  else { return }
            self.isAnimationStarted = true
            
            if value >= 100, self.frame.width == originalWidth {
                self.removeAnimation()
                resizeToLongWidth()
            }
            
            flipAnimation(direction: direction) {
                self.label.text = String(value)

                if self.animations.count > 1, self.animations[1].1 != direction {
                    self.removeAnimation()
                    if self.animations[1].0 <= 99, self.frame.width > self.originalWidth {
                        self.resizeToShortWidth()
                    }
                }
                self.isAnimationStarted = false
                self.animations.remove(at: 0)
            }
        }
    }
    
    private func removeAnimation() {
        for view in self.baseView.subviews{
            view.removeFromSuperview()
        }
    }
    
    private func addNewAnimation(param: (Int, FlipAnimationDirection)) {
        switch animations.count {
        case 0..<2:
            animations.append(param)
        default:
            animations.removeLast()
            animations.append(param)
        }
    }

    private func flipAnimation(direction: FlipAnimationDirection, completBlock: @escaping () -> ()) {
        
        var activeImageView: UIView!
        var transformDirection: CGFloat = 3.0
        var lastHalfTransformationImage: UIImage!
        let duration: Double = 0.7
        
        switch direction {
        case .Up:
            activeImageView = UIView(frame: bottomImageView.frame)
            transformDirection = -3.0
            lastHalfTransformationImage = bottomAnimationImage
        case .Down:
            activeImageView = UIView(frame: topImageView.frame)
            lastHalfTransformationImage = topAnimationImage
        }
        
        let image = self.snapshot(of: activeImageView.frame)
        var visiblePieceFlipView: UIImageView? = UIImageView(image: image)
        visiblePieceFlipView?.frame = activeImageView.frame
        
        var baseFlipView: UIView? = UIView(frame: baseView.frame)
        baseFlipView?.backgroundColor = .clear
        baseFlipView?.addSubview(visiblePieceFlipView!)
        baseView.addSubview(baseFlipView!)
        
        var flipTransform3D = CATransform3DIdentity
        flipTransform3D.m34 = transformDirection/270.0/2/2
        flipTransform3D = CATransform3DRotate(flipTransform3D, CGFloat.pi, 1, 0, 0)
        
        delay(duration/2) {
            visiblePieceFlipView?.image = lastHalfTransformationImage
            completBlock()
        }
        
        UIView.animate(withDuration: duration, animations: {
            baseFlipView?.layer.transform = flipTransform3D
        }, completion: { _ in
            baseFlipView?.removeFromSuperview()
            visiblePieceFlipView?.removeFromSuperview()
            visiblePieceFlipView = nil
            baseFlipView = nil
        })
    }

}

private extension UIView {
    
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let image = wholeImage, let rect = rect else { return wholeImage }
        
        let scale = image.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        
        return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
    }
}

