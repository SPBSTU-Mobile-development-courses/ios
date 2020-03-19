//
//  OriginalArticleController.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

import UIKit
import WebKit

final class OriginalArticleController: UIViewController {
    var articleTitle: String?
    var baseUrl: URL?

    @IBOutlet private var articleWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let articleTitle = self.articleTitle, let baseUrl = self.baseUrl
            else { return }
        self.navigationItem.title = articleTitle
        let request = URLRequest(url: baseUrl)
        self.articleWebView.load(request)
    }
}
