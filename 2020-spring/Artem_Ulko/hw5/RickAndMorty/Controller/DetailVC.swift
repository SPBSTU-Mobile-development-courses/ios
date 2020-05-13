//
//  DetailVC.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import Kingfisher
import UIKit

class DetailVC: UIViewController {
    @IBOutlet private var characterLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var animateLayerView: UIView!
    private let animateLayer = CALayer()
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCharacter()
        addGradient()
        imageView.layer.borderWidth = 1.0
        imageView.layer.backgroundColor = UIColor.white.cgColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addLayer()
        downLeftToUpCenter()
    }

    func downRightToDowndLeft() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.async {
                self.downLeftToUpCenter()
            }
        }
        let theAnimation3 = CABasicAnimation(keyPath: "position")
        theAnimation3.fromValue = CGPoint(x: animateLayerView.frame.width - 10, y: animateLayerView.frame.height - 10)
        theAnimation3.toValue = CGPoint(x: 10, y: animateLayerView.frame.height - 10)
        theAnimation3.duration = 3.0
        animateLayer.add(theAnimation3, forKey: "animatePosition")
        CATransaction.commit()
    }

    func upCenterToDownRight() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.async {
                self.downRightToDowndLeft()
            }
        }
        let theAnimation2 = CABasicAnimation(keyPath: "position")
        theAnimation2.fromValue = CGPoint(x: self.animateLayerView.frame.size.width / 2 - 10, y: 10.0)
        theAnimation2.toValue = CGPoint(x: animateLayerView.frame.width - 10, y: animateLayerView.frame.height - 10)
        theAnimation2.duration = 3.0
        animateLayer.add(theAnimation2, forKey: "animatePosition")
        CATransaction.commit()
    }

    func downLeftToUpCenter() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.async {
                self.upCenterToDownRight()
            }
        }
        let theAnimation = CABasicAnimation(keyPath: "position")
        theAnimation.fromValue = animateLayer.position
        theAnimation.toValue = CGPoint(x: self.animateLayerView.frame.size.width / 2 - 10, y: 10.0)
        theAnimation.duration = 3.0
        animateLayer.add(theAnimation, forKey: "animatePosition")
        CATransaction.commit()
    }

    private func setUpCharacter () {
        guard let character = character  else { return }

        let imageUrl = URL(string: character.image)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageUrl)
        characterLabel.text = "\(character.name) - \(character.status)"

    }

    private func addLayer() {
        animateLayer.frame = CGRect(x: 0, y: animateLayerView.frame.height - 20, width: 20, height: 20)
        animateLayerView.layer.addSublayer(animateLayer)
        animateLayer.backgroundColor = UIColor.gray.cgColor
        animateLayer.shadowOpacity = 0.5
        animateLayer.shadowRadius = 2.0
    }

    private func addGradient() {
        func cgColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
            UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0).cgColor
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            cgColor(red: 228.0, green: 167.0, blue: 136.0),
            cgColor(red: 240.0, green: 225.0, blue: 74.0)
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
