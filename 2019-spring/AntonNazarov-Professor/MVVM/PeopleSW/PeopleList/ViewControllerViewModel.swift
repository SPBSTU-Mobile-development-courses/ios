//
//  PeopleListViewModel.swift
//  PeopleSW
//
//  Created by Anton Nazarov on 06/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

protocol PeopleListViewModelProtocol {
    var onPeopleChanged: (([Person]) -> Void)? { get set }
    
    func loadMore()
}

class PeopleListViewModel: PeopleListViewModelProtocol {
    private let pageService: PeopleService
    private var nextUrl: String? = "https://swapi.co/api/people"
    private var people = [Person]() {
        didSet {
            onPeopleChanged?(people)
        }
    }
    var onPeopleChanged: (([Person]) -> Void)?
    
    init(pageService: PeopleService) {
        self.pageService = pageService
    }
    
    func loadMore() {
        pageService.getPage(url: nextUrl) { page, nextUrl in
            var currentPeople = self.people
            currentPeople.append(contentsOf: page)
            self.people = currentPeople
            self.nextUrl = nextUrl
        }
    }
}
