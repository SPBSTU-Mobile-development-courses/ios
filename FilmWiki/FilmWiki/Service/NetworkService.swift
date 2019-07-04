//
//  StarWarsService.swift
//  StarWarsWiki
//
//  Created by Виталий on 09.03.19.
//  Copyright © 2019 vlad. All rights reserved.
//

protocol NetworkService {
    associatedtype Element: Decodable
    func getData(_ completionHandler: @escaping ([Element]) -> Void)
}
