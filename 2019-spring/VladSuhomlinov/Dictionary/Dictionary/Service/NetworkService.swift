//
//  NetworkService.swift
//  Dictionary
//
//  Created by Мария on 20/03/2019.
//  Copyright © 2019 Мария. All rights reserved.
//

import Foundation

protocol NetworkService {
    associatedtype Element
    func getData(_ completionHandler: @escaping ([Element]?) -> Void)
}
