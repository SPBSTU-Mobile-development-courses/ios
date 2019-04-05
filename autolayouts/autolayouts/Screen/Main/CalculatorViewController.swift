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
    private let portraitMultiplier: CGFloat = 2.0
    private let landscapeMultiplier: CGFloat = 4.0
    private var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return AppDelegate()
        }
        return appDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appDelegate.enableAllOrientation = true
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        appDelegate.enableAllOrientation = false
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        portraitCornerRadius = (mainButtons.first?.frame.size.height ?? 0) / portraitMultiplier
        landscapeCornerRadius = (additionalButtons.first?.frame.size.height ?? 0) / landscapeMultiplier
        draw(buttons: additionalButtons, withCorner: landscapeCornerRadius)
        drawMainButtonsWithCurrentOrientation()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        drawMainButtonsWithCurrentOrientation()
    }
    
    func draw(buttons: [UIButton], withCorner radius: CGFloat) {
        for button in buttons {
            button.makeButton(withCorner: radius)
        }
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

// MARK: - UIButton
extension UIButton {
    func makeButton(withCorner radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
