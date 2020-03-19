//
//  ArticleService.swift
//  News
//
//  Created by Kirill Kungurov on 14.03.2020.
//  Copyright © 2020 Kirill Kungurov. All rights reserved.
//

protocol ArticleService {
    typealias AriclesCompletion = ([Article]?) -> Void

    var tag: String { get }

    func getArticles(completion: @escaping AriclesCompletion)
}
