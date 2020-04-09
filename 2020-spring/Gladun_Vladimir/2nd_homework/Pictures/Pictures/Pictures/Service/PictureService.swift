//
//  PictureService.swift
//  Pictures
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import Foundation

protocol PictureService {
  typealias PicturesCompletion = ([Image]?) -> Void
  
  func getPictures(completion: @escaping PicturesCompletion)
  func getMorePictures(completion: @escaping PicturesCompletion)
}

final class PicturesServiceImpl: PictureService {
  
  private var urlComponents = URLComponents(string: "https://pixabay.com")
  private var nextUrl: URL?
  private var pageNumber: Int = 1
  
  func getPictures(completion: @escaping PicturesCompletion) {
    urlComponents?.path = "/api/"
    urlComponents?.queryItems = [
      URLQueryItem(name: "key", value: "15846697-f4d84d0103154821222fb6535"),
      URLQueryItem(name: "image_type", value: "photo"),
      URLQueryItem(name: "page", value: "1")];
    guard let url = urlComponents?.url else {
      completion(nil)
      return
    }
    getPictures(url: url, completion: completion)
  }
  
  private func getNextPage()-> URL{
    pageNumber += 1
    urlComponents?.queryItems?[2].value = String(pageNumber)
    guard let newUrl = urlComponents?.url else {
      fatalError()
    }
    return newUrl
  }
  
  func getMorePictures(completion: @escaping PicturesCompletion) {
    guard let url = nextUrl else {
      completion(nil)
      return
    }
    getPictures(url: url, completion: completion)
  }
  
  private func getPictures(url: URL, completion:  @escaping PicturesCompletion) {
    print(url.absoluteString)
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      print(data)
      guard let page = try? JSONDecoder().decode(Page.self, from: data)  else { return }
      self.nextUrl = self.getNextPage()
      completion(page.hits)
    }
    .resume()
  }
}
