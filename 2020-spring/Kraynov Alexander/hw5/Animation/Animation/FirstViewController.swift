//
//  FirstViewController.swift
//  Animation
//
//  Created by Admin on 06.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import Then
import UIKit

class FirstViewController: UIViewController {
    let gradient = CAGradientLayer()
    var gradientColors = [[CGColor]]()
    var currentColor = 0

    @IBOutlet private var powerLabel: UILabel!
    @IBOutlet private var powerMeterView: PowerMeterView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpBackground()
        self.powerLabel.alpha = 0
    }
    @IBAction private func powerButtonPressed(_ sender: UIButton) {
        UIView.animate(
            withDuration: 1.0,
            animations: { sender.alpha = 0 },
            completion: { _ in
            sender.isHidden = true
            }
        )
        powerMeterView.setupPower(Double(Int.random(in: 1...100))) {
            UIView.animate(withDuration: 1) {
                self.powerLabel.alpha = 1
            }
        }
    }

    func setUpBackground() {
        let colorOne = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).cgColor
        let colorTwo = #colorLiteral(red: 0.5382522345, green: 0.369204402, blue: 0.9478774667, alpha: 1).cgColor
        let colorThree = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        gradientColors.append(contentsOf: [[colorOne, colorTwo], [colorTwo, colorThree], [colorThree, colorOne]])
        gradient.frame = self.view.bounds
        gradient.colors = gradientColors[currentColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.drawsAsynchronously = true
        view.layer.insertSublayer(gradient, at: 0)
        animateGradient()
    }

    func animateGradient() {
        currentColor += 1
        currentColor = currentColor % (gradientColors.count - 1)
        let gradientAnimation = CABasicAnimation(keyPath: "colors").then {
            $0.duration = 5.0
            $0.toValue = gradientColors[currentColor]
            $0.fillMode = CAMediaTimingFillMode.forwards
            $0.delegate = self
            $0.isRemovedOnCompletion = false
        }
        gradient.add(gradientAnimation, forKey: "gradientChangeAnimation")
    }
}

extension FirstViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientColors[currentColor]
            animateGradient()
        }
    }
}
