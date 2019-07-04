//
//  AppDelegate.swift
//  Notes
//
//  Created by Mordvintseva Alena on 10/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Reusable
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // swiftlint:disable:next discouraged_optional_collection
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let notesListViewController = NotesListViewController.instantiate()
        notesListViewController.viewModel = NotesListViewModel(database: DBServiceRealm())
        let navigationController = UINavigationController(rootViewController: notesListViewController)
        window?.rootViewController = navigationController

        return true
    }
}
