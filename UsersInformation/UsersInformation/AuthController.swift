//
//  ViewController.swift
//  UsersInformation
//
//  Created by Artem on 19/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class AuthController: UIViewController {
    @IBOutlet private var textLogin: UITextField!
    @IBOutlet private var textPassword: UITextField!

    private let userService = UserServiceNetwork()
    private var user: User?
    var status = "firstStart"

    @IBAction private func buttonClickSign(_ sender: UIButton) {
        guard let passw = textPassword.text else { return }
        guard let login = textLogin.text else { return }
        let urlBolart = "http://bolart.ru:3012/people/" + login + "/" + passw

        userService.getPage(url: urlBolart) {user in
            self.user = user
            DispatchQueue.main.async {
                guard user != nil else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect login or password", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                    return
                }
                self.performSegue(withIdentifier: "goToMainView", sender: self)
            }
        }
    }

    @IBAction private func buttonClickRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRegisterView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMainView" {
            guard let mainController = segue.destination as? MainController else { return }
            mainController.user = user
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
