//
//  ViewController.swift
//  tree
//
//  Created by Котов Иван on 12.03.2020.
//  Copyright © 2020 Котов Иван. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let m_tree: Tree = Tree<String>()
    @IBOutlet weak var m_keyField: NSTextField!
    @IBOutlet weak var m_valueField: NSTextField!
    @IBOutlet weak var m_addButton: NSButton!
    @IBOutlet weak var m_findButton: NSButton!
    @IBOutlet weak var m_deleteButton: NSButton!
    
    @IBAction func m_addButtonPress(_: NSButton) {
        m_tree.add(key: m_keyField.stringValue, value: m_valueField.stringValue)
    }
    @IBAction func m_deleteButtonPress(_ sender: NSButton) {
        m_tree.remove(key: m_keyField.stringValue)
    }
    
    @IBAction func m_findButtonClick(_ sender: NSButton) {
        m_valueField.stringValue = (m_tree.get(key: m_keyField.stringValue) ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

