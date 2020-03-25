//
//  MemeService.swift
//  HW2
//
//  Created by panandafog on 20.03.2020.
//  Copyright © 2020 panandafog. All rights reserved.
//
import Foundation

class MemeService {
    typealias PostsCompletion = ([Post]?) -> Void
    private var currentPage: Int = -1
    
    func getURL(page: Int) -> String{
        return("https://api.imgur.com/3/gallery/search/viral/all/" + String(page) + "?q=memes&q_type=jpg")
    }
    
    func getMemes(completion: @escaping PostsCompletion) {
        self.currentPage += 1
        guard let searchUrl = URL(string: getURL(page: self.currentPage)) else {
            completion(nil)
            return
        }
        var searchRequest = URLRequest(url: searchUrl)
        searchRequest.setValue("Client-ID c8828f10f679ec3", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: searchRequest) { (data, response, error) in
            
            guard let data = data, let page = try? JSONDecoder().decode(Page.self, from: data), var pageData = page.data, error == nil else {
                completion(nil)
                return
            }
            
            var index: Int = 0
            while index < pageData.count {
                if pageData[index].images == nil || ((pageData[index].images![0].type != "image/jpeg") && (pageData[index].images![0].type != "image/png")) {
                    pageData.remove(at: index)
                }
                index += 1
            }
            completion(pageData)
        }.resume()
    }
}
