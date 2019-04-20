//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Mordvintseva Alena on 11/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import UIKit
import UITextView_Placeholder

class AddNoteViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet private var titleText: UITextField!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!

    @IBAction private func cancelButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction private func chooseImageButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }

    @IBAction private func saveButton(_ sender: Any) {
        var data: [String: String] = [:]
        if let imagePath = imageView.saveImage() {
            data["imagePath"] = imagePath
        }
        data["title"] = titleText.text ?? ""
        data["text"] = textView.text ?? ""

        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: data)
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.translatesAutoresizingMaskIntoConstraints = false
        titleText.placeholder = "Title"
        textView.placeholder = "Note"
        textViewDidChange(textView)
        textView.delegate = self
    }
}

extension AddNoteViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageViewHeightConstraint.constant = imageView.frame.width * 3.0 / 4.0
        } else {
            print("Picking image failed")
        }

        self.dismiss(animated: true, completion: nil)
    }
}

extension AddNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.textView.frame.width, height: .infinity)
        let estimatedSize = self.textView.sizeThatFits(size)
        textViewHeightConstraint.constant = estimatedSize.height
    }
}
