//
//  AddToTableViewController.swift
//  calculator
//
//  Created by Admin on 23.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import UIKit

class AddToTableViewController: UIViewController{
    @IBOutlet weak var editText: UITextField!
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.data.append(editText.text ?? "")
    }
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
