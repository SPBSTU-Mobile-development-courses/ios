//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Mordvintseva Alena on 11/04/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation
import Reusable
import UIKit
import UITextView_Placeholder

class AddNoteViewController: UIViewController, UINavigationControllerDelegate, StoryboardBased {
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var titleView: UITextField!
    @IBOutlet private var noteView: UITextView!
    @IBOutlet private var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    private let imageService = ImageRepository()
    var onAddNote: ((Note) -> Void)?

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
            let imagePath = imageService.save(image: image)
            data["imagePath"] = imagePath
        }
        data["title"] = titleView.text ?? ""
        data["text"] = noteView.text ?? ""

        let note = Note(data: data)
        onAddNote?(note)
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        noteView.translatesAutoresizingMaskIntoConstraints = false
        titleView.placeholder = "Title"
        noteView.placeholder = "Note"
        textViewDidChange(noteView)
        noteView.delegate = self
        createToolbar()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        titleView.inputAccessoryView = toolBar
        noteView.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
