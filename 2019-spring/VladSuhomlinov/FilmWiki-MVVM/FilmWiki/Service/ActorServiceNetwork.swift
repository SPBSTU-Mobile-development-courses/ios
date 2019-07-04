//
//  ActorService.swift
//  FIlmWiki
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

class ActorServiceNetwork: NetworkService {
    private enum Const {
        static let infoURL = "https://en.wikipedia.org/wiki/"
    }
    private var title = ""
    
    init(withTitle title: String) {
        self.title = title
    }
    
    func getData(_ completionHandler: @escaping ([URLRequest]) -> Void) {
        let customName = title.replacingOccurrences(of: " ", with: "_")
        guard let infoURL = URL(string: Const.infoURL + customName) else { return }
        completionHandler([URLRequest(url: infoURL)])
    }
}
