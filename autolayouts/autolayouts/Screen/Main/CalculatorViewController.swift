//
//  ViewController.swift
//  autolayouts
//
//  Created by Виталий on 03.04.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITabBarControllerDelegate {
    @IBOutlet private var mainButtons: [UIButton]!
    @IBOutlet private var additionalButtons: [UIButton]!
    private var portraitCornerRadius: CGFloat = 0
    private var landscapeCornerRadius: CGFloat = 0
    private enum Const {
        static let portraitMultiplier: CGFloat = 2.0
        static let landscapeMultiplier: CGFloat = 3.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.appDelegate.enableAllOrientation = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.appDelegate.enableAllOrientation = false
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated() {
        switch UIDevice.current.orientation {
        case .portrait,
             .portraitUpsideDown where portraitCornerRadius == 0:
            portraitCornerRadius = (mainButtons.first?.bounds.size.height ?? 0) / Const.portraitMultiplier
        case .landscapeLeft,
             .landscapeRight where landscapeCornerRadius == 0:
            landscapeCornerRadius = (additionalButtons.first?.bounds.size.height ?? 0) / Const.landscapeMultiplier
            draw(buttons: additionalButtons, withCorner: landscapeCornerRadius)
        default:
            break
        }
        drawMainButtonsWithCurrentOrientation()
    }
    
    func draw(buttons: [UIButton], withCorner radius: CGFloat) {
        buttons.forEach { $0.make(withCorner: radius) }
    }
    
    func drawMainButtonsWithCurrentOrientation() {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            draw(buttons: mainButtons, withCorner: portraitCornerRadius)
            tabBarController?.makeItem(atIndex: 1, enable: true)
        default:
            draw(buttons: mainButtons, withCorner: landscapeCornerRadius)
            tabBarController?.makeItem(atIndex: 1, enable: false)
        }
    }
}
