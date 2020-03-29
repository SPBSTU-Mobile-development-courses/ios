//
//  ActorWebViewController.swift
//  StarWarsWiki
//
//  Created by Виталий on 12.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit
import WebKit

class ActorWebViewController: UIViewController {
    @IBOutlet private var actorWebView: WKWebView!
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var actorWebViewModel: ActorWebViewModel!
    private var actorURLRequest: URLRequest? {
        didSet {
            guard let actorURLRequest = actorURLRequest else { return }
            self.actorWebView.load(actorURLRequest)
        }
    }
    var actorName = "" {
        didSet {
            actorWebViewModel = ActorWebViewModel(actorService: ActorServiceNetwork(withTitle: actorName))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Wiki"
        actorWebViewModel?.onActorRequestChanged = { [weak self] request in
                self?.actorURLRequest = request
        }
        actorWebViewModel?.getRequest()
    }
}

// MARK: StoryboardSceneBased
extension ActorWebViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "ActorWebInfo", bundle: nil)
    }
}
