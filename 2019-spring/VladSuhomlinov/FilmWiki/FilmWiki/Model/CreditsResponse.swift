//
//  CreditsResponse.swift
//  FIlmWiki
//
//  Created by Мария on 14/03/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

public struct CreditsResponse: Decodable {
    let cast: [Actor]
}
