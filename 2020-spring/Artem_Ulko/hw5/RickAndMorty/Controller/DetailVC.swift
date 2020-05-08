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
    private var squareAnimation: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCharacter()
        addGradient()
        addLayer()
        setUpTimer()
        imageView.layer.borderWidth = 1.0
        imageView.layer.backgroundColor = UIColor.white.cgColor
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.animateLayer.frame = CGRect(x: self.animateLayerView.frame.size.width - 20, y: 0, width: 20, height: 20)
//        }

    }

    func setUpTimer() {
        squareAnimation = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(squareAnimationTick),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func squareAnimationTick() {
        self.animateLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: 20,
            height: 20
        )
    }

    private func setUpCharacter () {
        guard let character = character  else { return }

        let imageUrl = URL(string: character.image)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageUrl)
        characterLabel.text = "\(character.name) - \(character.status)"

    }

    private func addLayer() {
        animateLayer.frame = CGRect(x: 0, y: 263, width: 20, height: 20)
        animateLayerView.layer.addSublayer(animateLayer)
        animateLayer.backgroundColor = UIColor.gray.cgColor
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
//           view.layer.addSublayer(gradientLayer)
            view.layer.insertSublayer(gradientLayer, at: 0)
       }
}
