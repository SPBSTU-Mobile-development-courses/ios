//
//  ViewController.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import RealmSwift
import UIKit

class AuthController: UIViewController {
    @IBOutlet private var textLogin: UITextField!
    @IBOutlet private var textPassword: UITextField!

    private let usersRealm = UsersRealm()
    private let userService = UserServiceNetwork()
    private let authStatus = "authStatus"
    private let loginKey = "login"
    private let passwordKey = "password"
    private lazy var userInRealm = usersRealm.getUsers()
    private var user: User?

    @IBAction private func buttonClickSign(_ sender: UIButton) {
        guard let passw = textPassword.text else { return }
        guard let login = textLogin.text else { return }

        userService.getUser(login: login, password: passw) { user in
            self.user = user
            DispatchQueue.main.async {
                guard let user = user else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect login or password", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                    alert.addAction(cancelAction)
                    self.textPassword.text = ""
                    self.present(alert, animated: true)
                    return
                }
                self.usersRealm.updateMainUser(user: user)
                UserDefaults.standard.set(login, forKey: self.loginKey)
                UserDefaults.standard.set(passw, forKey: self.passwordKey)
                UserDefaults.standard.set("autorized", forKey: self.authStatus)

                self.performSegue(withIdentifier: "goToMainView", sender: self)
            }
        }
    }

    @IBAction private func buttonClickRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRegisterView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMainView" {
            // swiftlint:disable:next force_cast
            let myTabbarController: UITabBarController = segue.destination as! UITabBarController
            guard let mainViewController = myTabbarController.viewControllers?[0] as? MainController else { return }
            mainViewController.user = self.user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let status = UserDefaults.standard.string(forKey: authStatus) else { return }
        if status.isEqual("autorized") {
            guard let login = UserDefaults.standard.string(forKey: loginKey) else { return }
            guard let passw = UserDefaults.standard.string(forKey: passwordKey) else { return }
            userService.getUser(login: login, password: passw) { user in
                self.user = user
                DispatchQueue.main.async {
                    guard let user = user else {
                        let alert = UIAlertController(title: "Error", message: "Incorrect login or password", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                        alert.addAction(cancelAction)
                        self.textPassword.text = ""
                        self.present(alert, animated: true)
                        return
                    }
                    self.usersRealm.updateMainUser(user: user)
                    self.performSegue(withIdentifier: "goToMainView", sender: self)
                }
            }
        }
    }
}
