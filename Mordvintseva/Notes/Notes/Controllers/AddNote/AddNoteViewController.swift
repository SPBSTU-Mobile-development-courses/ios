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
    @IBOutlet private var titleView: UITextField!
    @IBOutlet private var noteView: UITextView!
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
        if titleView.text?.isEmpty == true || noteView.text.isEmpty == true {
            let alertController = UIAlertController(title: "Empty field", message: "One of fields is empty", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            self.present(alertController, animated: true, completion: nil)
            return
        }

        var data: [String: String] = [:]
        if let image = imageView.image {
            let imagePath = ImageService().save(image: image)
            data["imagePath"] = imagePath
        }
        data["title"] = titleView.text ?? ""
        data["text"] = noteView.text ?? ""

        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: data)
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteView.translatesAutoresizingMaskIntoConstraints = false
        titleView.placeholder = "Title"
        noteView.placeholder = "Note"
        textViewDidChange(noteView)
        noteView.delegate = self
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
        let size = CGSize(width: self.noteView.frame.width, height: .infinity)
        let estimatedSize = self.noteView.sizeThatFits(size)
        textViewHeightConstraint.constant = estimatedSize.height
    }
}
