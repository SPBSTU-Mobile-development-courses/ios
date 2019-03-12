//
//  ActorWebViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 12.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import WebKit

class ActorWebViewController: UIViewController {
    @IBOutlet weak var actorWebView: WKWebView!
    var actorName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wiki"
        let customName = actorName.replacingOccurrences(of: " ", with: "_")
        let url = URL(string: "https://en.wikipedia.org/wiki/\(customName)")
        let request = URLRequest(url: url!)
        self.actorWebView.load(request)
    }
}
