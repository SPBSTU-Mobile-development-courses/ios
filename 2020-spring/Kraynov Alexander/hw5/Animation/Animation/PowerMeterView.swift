//
//  PowerMeterView.swift
//  Animation
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class PowerMeterView: UIView {
    private var power = 0.0
    private var showPulse = 0
    private var completion: () -> Void = {}
    private lazy var powerLabel: UILabel = {
        let powerLabel = UILabel(
            frame: CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: bounds.width, height: bounds.height)
            )
        )
        powerLabel.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        powerLabel.textAlignment = NSTextAlignment.center
        powerLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return powerLabel
    }()
    private lazy var foregroundLayer: CAShapeLayer = {
        let foregroundLayer = CAShapeLayer()
        foregroundLayer.lineWidth = 10
        foregroundLayer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        foregroundLayer.lineCap = .round
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeEnd = 0
        foregroundLayer.frame = bounds
        return foregroundLayer
    }()
       private lazy var backgroundLayer: CAShapeLayer = {
           let backgroundLayer = CAShapeLayer()
           backgroundLayer.lineWidth = 10
           backgroundLayer.strokeColor = UIColor.lightGray.cgColor
           backgroundLayer.lineCap = .round
           backgroundLayer.fillColor = UIColor.clear.cgColor
           backgroundLayer.frame = bounds
           return backgroundLayer
       }()

    private lazy var foregroundGradientLayer: CAGradientLayer = {
        let foregroundGradientLayer = CAGradientLayer()
        foregroundGradientLayer.frame = bounds
        let startColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
        let secondColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        foregroundGradientLayer.colors = [startColor, secondColor]
        foregroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        foregroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
        return foregroundGradientLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayers()
    }

    private func createLayers() {
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2 )
        let path = UIBezierPath(
            arcCenter: center,
            radius: 100,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 2 - CGFloat.pi / 2,
            clockwise: true
        )
        backgroundLayer.path = path.cgPath
        layer.addSublayer(backgroundLayer)
        foregroundLayer.path = path.cgPath
        foregroundGradientLayer.mask = foregroundLayer
        layer.addSublayer(foregroundGradientLayer)
        addSubview(powerLabel)
    }

    private func animateForegroundLayer() {
           let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd")
           foregroundAnimation.fromValue = 0
        foregroundAnimation.toValue = CGFloat(power / 100)
           foregroundAnimation.duration = 5
           foregroundAnimation.fillMode = CAMediaTimingFillMode.forwards
           foregroundAnimation.isRemovedOnCompletion = false
           foregroundAnimation.delegate = self
           foregroundLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
       }

    private func animateShimmeringDown() {
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd")
        foregroundAnimation.fromValue = CGFloat(power / 100)
        foregroundAnimation.toValue = CGFloat((max(0, power - 2)) / 100)
        foregroundAnimation.duration = 1
        foregroundAnimation.fillMode = CAMediaTimingFillMode.forwards
        foregroundAnimation.isRemovedOnCompletion = false
        foregroundAnimation.autoreverses = true
        foregroundAnimation.delegate = self
        foregroundAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        foregroundLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
    }

    func setupPower(_ power: Double, completion: @escaping () -> Void) {
        self.power = power
        self.completion = completion
        animateForegroundLayer()
    }
}

extension PowerMeterView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animateShimmeringDown()
        powerLabel.text = "\(Int(power))!"
        completion()
    }
}
