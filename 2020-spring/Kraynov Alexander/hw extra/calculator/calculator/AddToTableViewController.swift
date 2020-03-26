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
        editText.text = ""
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let textFrame = editText.superview?.convert(editText.frame, to: nil)
        let notchOffset = self.view.safeAreaInsets.top
        scrollView.setContentOffset(CGPoint(x: 0, y: (textFrame?.minY ?? 0) - notchOffset), animated: true)
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        editText.resignFirstResponder()
    }
}
