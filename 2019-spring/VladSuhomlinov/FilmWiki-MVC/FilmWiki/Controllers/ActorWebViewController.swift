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
    private enum Const {
        static let infoURL = "https://en.wikipedia.org/wiki/"
    }
    
    @IBOutlet private var actorWebView: WKWebView!
    // swiftlint:disable implicitly_unwrapped_optional
    private var actorName: String!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wiki"
        let customName = actorName.replacingOccurrences(of: " ", with: "_")
        guard let infoURL = URL(string: Const.infoURL + customName) else { return }
        let request = URLRequest(url: infoURL)
        self.actorWebView.load(request)
    }
    
    func set(actorName: String) {
        self.actorName = actorName
    }
}
