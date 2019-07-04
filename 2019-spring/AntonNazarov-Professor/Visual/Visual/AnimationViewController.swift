//
//  AnimationViewController.swift
//  Visual
//
//  Created by Anton Nazarov on 20/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    var timer: Timer!
    @IBOutlet private var animationButton: UIButton!
    @IBAction func doThings() {
        animate()
//        animateEasier()
    }

    func animate() {
        let theAnimation = CABasicAnimation(keyPath: "position")
        theAnimation.fromValue =  animationButton.layer.position
        theAnimation.toValue = CGPoint(x: 100.0, y: 400.0)
        theAnimation.duration = 3.0
        theAnimation.autoreverses = true
        theAnimation.repeatCount = 2
        animationButton.layer.add(theAnimation, forKey: "animatePosition")
    }

    func animateEasier() {
        UIView.animate(withDuration: 3.0) {
            self.animationButton.frame = CGRect(
                origin: CGPoint(x: 100.0, y: 400.0),
                size: self.animationButton.frame.size
            )
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(showModelPresentation), userInfo: nil, repeats: true)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    @objc func showModelPresentation() {
        print("Model: \(animationButton.layer.model().position), presentation: \(animationButton.layer.presentation()!.position)))")
    }
}
