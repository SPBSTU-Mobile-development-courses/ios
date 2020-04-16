//
//  PowerMeterView.swift
//  Animation
//
//  Created by Admin on 09.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Then
import UIKit

class PowerMeterView: UIView {
    private var power = 0.0
    private var showPulse = 0
    private var completion: () -> Void = {}
    private lazy var powerLabel =
        UILabel(
            frame: CGRect(
                origin: .zero,
                size: bounds.size
            )
        ).then {
            $0.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
            $0.textAlignment = .center
            $0.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }

    private lazy var foregroundLayer = CAShapeLayer().then {
        $0.lineWidth = 10
        $0.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        $0.lineCap = .round
        $0.fillColor = UIColor.clear.cgColor
        $0.strokeEnd = 0
        $0.frame = bounds
    }

    private lazy var backgroundLayer = CAShapeLayer().then {
        $0.lineWidth = 10
        $0.strokeColor = UIColor.lightGray.cgColor
        $0.lineCap = .round
        $0.fillColor = UIColor.clear.cgColor
        $0.frame = bounds
    }
    private lazy var foregroundGradientLayer = CAGradientLayer().then {
        $0.frame = bounds
        let startColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
        let secondColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        $0.colors = [startColor, secondColor]
        $0.startPoint = .zero
        $0.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayers()
    }

    private func createLayers() {
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let path = UIBezierPath(
            arcCenter: center,
            radius: 100,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 1.75,
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
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd").then {
            $0.fromValue = 0
            $0.toValue = CGFloat(power / 100)
            $0.duration = 5
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
            $0.delegate = self
        }
        foregroundLayer.add(foregroundAnimation, forKey: "foregroundAnimation")
       }

    private func animateShimmeringDown() {
        let foregroundAnimation = CABasicAnimation(keyPath: "strokeEnd").then {
            $0.fromValue = CGFloat(power / 100)
            $0.toValue = CGFloat((max(0, power - 2)) / 100)
            $0.duration = 1
            $0.fillMode = .forwards
            $0.isRemovedOnCompletion = false
            $0.autoreverses = true
            $0.delegate = self
            $0.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        }
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
