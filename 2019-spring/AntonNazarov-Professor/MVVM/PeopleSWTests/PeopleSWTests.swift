//
//  PeopleSWTests.swift
//  PeopleSWTests
//
//  Created by Anton Nazarov on 06/04/2019.
//  Copyright © 2019 Anton Nazarov. All rights reserved.
//

import XCTest
@testable import PeopleSW

class PeopleSWTests: XCTestCase {
    private var viewModel: PeopleListViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = PeopleListViewModel(pageService: StubPeopleService())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testExample() {
        var onPeopleChangedWasCalled = false
        viewModel.onPeopleChanged = { _ in
            onPeopleChangedWasCalled = true
        }
        
        viewModel.loadMore()
        
        XCTAssertTrue(onPeopleChangedWasCalled)
    }
}

private extension PeopleSWTests {
    final class StubPeopleService: PeopleService {
        func getPage(url: String?, _ completionHandler: @escaping (([Person], String?) -> Void)) {
            completionHandler([], nil)
        }
    }
}
