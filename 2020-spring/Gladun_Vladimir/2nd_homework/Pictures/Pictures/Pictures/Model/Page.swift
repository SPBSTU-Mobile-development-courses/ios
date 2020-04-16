//
//  Page.swift
//  Pictures
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import Foundation

struct Page: Decodable {
  let hits:[Image]
}

struct Image: Decodable {
  let tags: String
  let previewURL : String
  let favorites : Int
  let likes : Int
  let comments : Int
  let user: String
  let userImageURL : String
  var url: URL? {URL(string:previewURL)}
  var urlUser: URL? {URL(string:userImageURL)}
}
