//
//  ViewController.swift
//  Visual
//
//  Created by Anton Nazarov on 20/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var layerView: UIView!

    let layer2 = CALayer()

    @IBAction func doThings(_ sender: Any) {
        layer2.backgroundColor = UIColor.green.cgColor
        layer2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addLayer()
    }

    // 0
    func setupLayerView() {
        layerView.layer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.borderWidth = 100.0
        layerView.layer.borderColor = UIColor.red.cgColor
        layerView.layer.shadowOpacity = 0.7
        layerView.layer.shadowRadius = 10.0
        layerView.layer.cornerRadius = 40.0
    }


    // 1
    func addLayer() {
        layer2.frame = layerView.bounds
        layerView.layer.addSublayer(layer2)
        layer2.backgroundColor = UIColor.red.cgColor
    }


    // 2
    func addGradient() {
        func cgColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [cgColor(red: 209.0, green: 0.0, blue: 0.0),
                                cgColor(red: 255.0, green: 102.0, blue: 34.0),
                                cgColor(red: 255.0, green: 218.0, blue: 33.0),
                                cgColor(red: 51.0, green: 221.0, blue: 0.0),
                                cgColor(red: 17.0, green: 51.0, blue: 204.0),
                                cgColor(red: 34.0, green: 0.0, blue: 102.0),
                                cgColor(red: 51.0, green: 0.0, blue: 68.0)]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        view.layer.addSublayer(gradientLayer)
    }

}

