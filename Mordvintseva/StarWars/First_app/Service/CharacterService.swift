//
//  CharacterService.swift
//  First_app
//
//  Created by Mordvintseva Alena on 10/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import Foundation

protocol CharacterService {
    func getCharacters(_ completionHandler: @escaping (([Character]) -> Void))
    func getItemByURL<T: Decodable>(url: URL, completionHandler: @escaping ((T) -> Void))
}
