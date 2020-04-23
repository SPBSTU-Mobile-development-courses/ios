//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 06.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        let characterViewController = CharacterViewController.instantiate()
        characterViewController.characterFacade = CharacterFacadeImpl(
            characterService: CharacterServiceImpl(), characterRepository: CharacterRepositoryImpl()
        )
        window?.rootViewController = UINavigationController(rootViewController: characterViewController)
        window?.makeKeyAndVisible()
    }
}
