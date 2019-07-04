//
//  AppDelegate.swift
//  autolayouts
//
//  Created by Виталий on 03.04.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var enableAllOrientation = false
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return enableAllOrientation ? .allButUpsideDown : .portrait
    }
}
