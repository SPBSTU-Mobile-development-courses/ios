//
//  AnimationViewController.swift
//  NewsAPI
//
//  Created by Никита Фролов  on 05.05.2020.
//  Copyright © 2020 Никита Фролов . All rights reserved.
//

import UIKit
import CoreGraphics

class AnimationViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView(frame: CGRect(x: 100, y: 20, width: 200, height: 200))
        view.backgroundColor = UIColor.black
        
        let shadowView = UIView(frame: CGRect(x: 50, y: 20, width: 220, height: 220))
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize.zero
        
        shadowView.addSubview(view)
        self.view.addSubview(shadowView)
        UIView.animate(withDuration: 1,
        delay: 0,
        options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat],
        animations: {
            view.backgroundColor = UIColor.red
            shadowView.frame = CGRect(
                origin:  CGPoint(x: 100, y: 500),
                size: view.frame.size
            )
          },
        completion: nil)
    }
}
