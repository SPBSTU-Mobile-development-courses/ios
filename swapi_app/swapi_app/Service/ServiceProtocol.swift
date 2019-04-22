//
//  ServiceProtocol.swift
//  swapi_app
//
//  Created by Andrew on 21/04/2019.
//  Copyright © 2019 SPbSTU. All rights reserved.
//

protocol ServiceProtocol {
    func getPage(_ completionHandler: @escaping (([Person]) -> Void))
}
