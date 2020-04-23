//
//  ViewController.swift
//  animeme
//
//  Created by panandafog on 23.04.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var originalSize: CGRect = CGRect()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        image.center.x  -= view.bounds.width
        originalSize = image.frame
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        image.layer.shouldRasterize = true
        image.layer.masksToBounds = false

        UIView.animate(withDuration: 0.7, animations: {
            self.image.center.x += self.view.bounds.width
        }, completion: { _ in
            UIView.animate(withDuration: 0.7, animations: {
                self.image.frame.size.width *= 2.5
                self.image.frame.size.height *= 4
                self.image.center = self.view.center
            }, completion: { _ in

                UIView.animate(withDuration: 2, animations: {
                    self.image.frame.size.width = self.originalSize.width * 1.4
                    self.image.frame.size.height = self.originalSize.height * 0.7
                    self.image.center = self.view.center
                }, completion: { _ in

                    let image2 = UIImageView(image: self.image.image)
                    image2.frame = self.image.frame

                    image2.layer.shouldRasterize = true
                    image2.layer.masksToBounds = false

                    image2.frame.size.height = self.originalSize.height * 0.7
                    image2.frame.size.width = self.originalSize.width * 0.7

                    image2.center.x = self.image.center.x + self.image.frame.size.width / 4
                    image2.center.y = self.image.center.y

                    self.view.addSubview(image2)
                    self.view.bringSubviewToFront(self.image)

                    UIView.animate(withDuration: 2, animations: {
                        self.image.center.x = image2.center.x - self.image.frame.size.width / 4
                        self.image.frame.size.width /= 2
                    }, completion: { _ in
                        self.setShadows(image: self.image)
                        self.setShadows(image: image2)
                        self.shake(image: self.image, upside: true)
                        self.shake(image: image2, upside: false)
                    })
                })
            })
        })
    }

    func shake(image: UIImageView, upside: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            if upside {
                image.center.y = image.frame.size.height / 2
            } else {
                image.center.y = self.view.bounds.height - image.frame.size.height / 2
            }
        }, completion: { _ in
            self.shake(image: image, upside: !upside)
        })
    }

    func setShadows(image: UIImageView) {
                image.layer.shadowColor = UIColor(named: "#df544a")?.cgColor
                image.layer.shadowOpacity = 1
                image.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
                image.layer.shadowRadius = 10
    }
}
