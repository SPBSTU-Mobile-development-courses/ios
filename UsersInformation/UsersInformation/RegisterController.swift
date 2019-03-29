//
//  RegisterController.swift
//  UsersInformation
//
//  Created by Artem on 20/03/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet private var textFieldLogin: UITextField!
    @IBOutlet private var textFieldName: UITextField!
    @IBOutlet private var textFieldAge: UITextField!
    @IBOutlet private var textFieldHeight: UITextField!
    @IBOutlet private var textFieldMass: UITextField!
    @IBOutlet private var textFieldPassword: UITextField!
    @IBOutlet private var textFieldConfirmPassword: UITextField!
    @IBOutlet private var btnMale: UIButton!
    @IBOutlet private var btnFemale: UIButton!
    @IBOutlet private var scrollView: UIScrollView!

    private var gender = "Male"
    private let userServiceNetwork = UserServiceNetwork()

    @IBAction private func selectFemale(_ sender: UIButton) {
        gender = "Female"
        btnFemale.isSelected = true
        btnMale.isSelected = false
    }

    @IBAction private func selectMale(_ sender: UIButton) {
        gender = "Male"
        btnFemale.isSelected = false
        btnMale.isSelected = true
    }

    @IBAction private func buttonClickCreateAccount(_ sender: UIButton) {
        let login = textFieldLogin.text
        let pass = textFieldPassword.text
        let equalPass = pass == textFieldConfirmPassword.text
        guard let loginEqual = login, let passEqual = pass else { return }
        if  !loginEqual.isEmpty && !passEqual.isEmpty {
            if equalPass {
                var user = User()
                user.login = login
                user.name = textFieldName.text
                user.age = textFieldAge.text
                user.gender = gender
                user.password = pass
                user.height = textFieldHeight.text
                user.mass = textFieldMass.text
                userServiceNetwork.sendUser(user: user) { status in
                    if status {
                        let alert = UIAlertController(title: "Successfull!", message: "Success registration. Sign now!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                            self.navigationController?.popToRootViewController(animated: true)
                        }

                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Failed registration. Try again.", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                        alert.addAction(cancelAction)
                        self.present(alert, animated: true)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Passwords not equal", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Login, name and password are required", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func keyboard(notification: Notification) {
        let userInfo = notification.userInfo
        // swiftlint:disable:next force_cast
        let keyboardScreenEndFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
