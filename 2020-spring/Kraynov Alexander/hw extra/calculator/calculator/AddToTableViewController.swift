//
//  AddToTableViewController.swift
//  calculator
//
//  Created by Admin on 23.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class AddToTableViewController: UIViewController {
    @IBOutlet private var editText: UITextView!
    @IBOutlet private var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AddToTableViewController.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    @IBAction private func confirmButtonPressed(_ sender: UIButton) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        delegate.data.append(editText.text ?? "")
        editText.endEditing(true)
        scrollView.contentInset.bottom = 0
        editText.text = ""
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrollView.contentInset.bottom = keyboardHeight
        }
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        editText.resignFirstResponder()
        scrollView.contentInset.bottom = 0
    }
}
