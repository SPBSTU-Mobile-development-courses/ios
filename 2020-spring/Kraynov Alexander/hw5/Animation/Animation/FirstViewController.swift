//
//  FirstViewController.swift
//  Animation
//
//  Created by Admin on 06.04.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let gradient = CAGradientLayer()
    var gradientColors = [[CGColor]]()
    var currentColor = 0

    @IBOutlet private var powerLabel: UILabel!
    @IBOutlet private var powerMeterView: PowerMeterView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
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
            self.powerLabel.isHidden = false
        }
    }

    func setUpBackground() {
        let colorOne = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1).cgColor
        let colorTwo = #colorLiteral(red: 0.5382522345, green: 0.369204402, blue: 0.9478774667, alpha: 1).cgColor
        let colorThree = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
        gradientColors.append([colorOne, colorTwo])
        gradientColors.append([colorTwo, colorThree])
        gradientColors.append([colorThree, colorOne])
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
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.duration = 5.0
        gradientAnimation.toValue = gradientColors[currentColor]
        gradientAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientAnimation.delegate = self
        gradientAnimation.isRemovedOnCompletion = false
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
