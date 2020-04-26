//
//  ViewController.swift
//  animeme
//
//  Created by panandafog on 23.04.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bound: CGFloat = 0.0
    let duration = 4.0

    @IBOutlet private var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        image.center.x -= view.bounds.width
        bound = image.frame.width / 2
        image.center = CGPoint(x: bound, y: bound)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        image.layer.shouldRasterize = true
        image.layer.masksToBounds = false

        let image2 = UIImageView(image: self.image.image)
        image2.frame = self.image.frame

        image2.layer.shouldRasterize = true
        image2.layer.masksToBounds = false

        image2.frame.size = image.frame.size
        image2.center = CGPoint(x: self.view.bounds.width - bound, y: self.view.bounds.height - bound)
        self.view.addSubview(image2)

        madFlex(image: image, startIndex: 0)
        madFlex(image: image2, startIndex: 2)
    }

    func setShadows(image: UIImageView) {
        image.layer.shadowColor = UIColor(named: "#df544a")?.cgColor
        image.layer.shadowOpacity = 1
        image.layer.shadowRadius = 10
    }

    func rotate(image: UIImageView) {
        UIView.animate(withDuration: 0.5,
                       animations: {
                        image.transform = image.transform.rotated(by: CGFloat(Double.pi / 2))
        }, completion: { _ in
            self.rotate(image: image)
        })
    }

    func madFlex(image: UIImageView, startIndex: Int) {
        setShadows(image: image)
        let move = CAKeyframeAnimation(keyPath: "position")
        let way: [CGPoint]
        switch startIndex {
        case 0:
            way = [
                CGPoint(x: bound, y: bound),
                CGPoint(x: self.view.bounds.width - bound * 1.5, y: bound * 1.5),
                CGPoint(x: self.view.bounds.width - bound * 2, y: self.view.bounds.height - bound * 2),
                CGPoint(x: bound * 1.5, y: self.view.bounds.height - bound * 1.5),
                CGPoint(x: bound, y: bound)
            ]
        case 1:
            way = [
                CGPoint(x: self.view.bounds.width - bound, y: bound),
                CGPoint(x: self.view.bounds.width - bound * 1.5, y: self.view.bounds.height - bound * 1.5),
                CGPoint(x: bound * 2, y: self.view.bounds.height - bound * 2),
                CGPoint(x: bound * 1.5, y: bound * 1.5),
                CGPoint(x: self.view.bounds.width - bound, y: bound)
            ]
        case 2:
            way = [
                CGPoint(x: self.view.bounds.width - bound, y: self.view.bounds.height - bound),
                CGPoint(x: bound * 1.5, y: self.view.bounds.height - bound * 1.5),
                CGPoint(x: bound * 2, y: bound * 2),
                CGPoint(x: self.view.bounds.width - bound * 1.5, y: bound * 1.5),
                CGPoint(x: self.view.bounds.width - bound, y: self.view.bounds.height - bound)
            ]
        case 3:
            way = [
                   CGPoint(x: bound, y: self.view.bounds.height - bound),
                   CGPoint(x: bound * 1.5, y: bound * 1.5),
                   CGPoint(x: self.view.bounds.width - bound * 2, y: bound * 2),
                   CGPoint(x: self.view.bounds.width - bound * 1.5, y: self.view.bounds.height - bound * 1.5),
                   CGPoint(x: bound, y: self.view.bounds.height - bound)
            ]
        default:
            print("wrong index")
            return
        }

        move.values = way

        move.duration = self.duration
        move.autoreverses = false

        let resize = CABasicAnimation(keyPath: "bounds.size")

        resize.fromValue = image.layer.bounds.size
        resize.toValue = CGSize(width: image.layer.bounds.width * 2, height: image.layer.bounds.height * 2)
        resize.duration = self.duration / 2
        resize.autoreverses = true
        image.layer.add(resize, forKey: "animateBounds.size")

        let group = CAAnimationGroup()
        group.animations = [move, resize]
        group.duration = self.duration
        group.repeatCount = Float.greatestFiniteMagnitude
        rotate(image: image)
        image.layer.add(group, forKey: nil)
    }
}
