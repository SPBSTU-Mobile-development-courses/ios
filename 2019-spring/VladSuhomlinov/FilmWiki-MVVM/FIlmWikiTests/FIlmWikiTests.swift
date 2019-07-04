//
//  FIlmWikiTests.swift
//  FIlmWikiTests
//
//  Created by Мария on 19/04/2019.
//  Copyright © 2019 vlad. All rights reserved.
//

@testable import FIlmWiki
import XCTest

class FIlmWikiTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    private var filmViewModel: FilmViewModelProtocol!
    private var infoFilmViewModel: InfoFilmViewModelProtocol!
    private var actorWebViewModel: ActorWebViewModelProtocol!
    private var actorName = ""
    
    override func setUp() {
        super.setUp()
        filmViewModel = FilmViewModel(filmService: StubFilmServiceNetwork())
        infoFilmViewModel = InfoFilmViewModel(infoFilmService: StubInfoFilmServiceNetwork())
        actorWebViewModel = ActorWebViewModel(actorService: ActorServiceNetwork(withTitle: actorName))
    }
    
    func testOnFilmsAppended() {
        var onFilmsAppendedWasCalled = false
        filmViewModel.onFilmsAppended = { _ in
            onFilmsAppendedWasCalled = true
        }
        filmViewModel.loadMore()
        
        XCTAssertTrue(onFilmsAppendedWasCalled)
    }
    
    func testOnActorsChanged() {
        var onActorsChangedWasCalled = false
        infoFilmViewModel.onActorsChanged = { _ in
            onActorsChangedWasCalled = true
        }
        infoFilmViewModel.loadMore()
        
        XCTAssertTrue(onActorsChangedWasCalled)
    }
    
    func testOnActorRequestChanged() {
        var onActorRequestChangedWasCalled = false
        actorWebViewModel.onActorRequestChanged = { _ in
            onActorRequestChangedWasCalled = true
        }
        actorWebViewModel.getRequest()
        
        XCTAssertTrue(onActorRequestChangedWasCalled)
    }
    
    override func tearDown() {
        filmViewModel = nil
        infoFilmViewModel = nil
        actorWebViewModel = nil
        super.tearDown()
    }
}

// MARK: StubFilmServiceNetwork
private extension FIlmWikiTests {
    final class StubFilmServiceNetwork: NetworkService {
        func getData(_ completionHandler: @escaping ([Film]) -> Void) {
            completionHandler([])
        }
    }
}

// MARK: StubInfoFilmServiceNetwork
private extension FIlmWikiTests {
    final class StubInfoFilmServiceNetwork: NetworkService {
        func getData(_ completionHandler: @escaping ([Actor]) -> Void) {
            completionHandler([])
        }
    }
}
