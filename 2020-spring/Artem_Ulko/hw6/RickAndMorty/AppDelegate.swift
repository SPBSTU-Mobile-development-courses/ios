//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by user on 22.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = window?.rootViewController as! UINavigationController
        let tableVC = navigationController.topViewController as! TableVC
        tableVC.characterFacade = CharacterFacadeImpl(
            characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl()
        )
        
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let tableVC = TableVC()
//        tableVC.characterFacade = CharacterFacadeImpl(
//            characterService: CharacterService(), characterRepository: CharacterRepositoryImpl()
//        )
//        window.rootViewController = UINavigationController(rootViewController: tableVC)
//        window.makeKeyAndVisible()
//        self.window = window
        return true
    }

}
