@testable import LoremNuntium

import XCTest

import RealmSwift

class NewsHeaderFacadeTests: XCTestCase {

    private var sut: NHFacade!
    private var service: ServiceMock!
    private var repository: RepositorySpy!

    override func setUp() {
        super.setUp()
        service = ServiceMock()
        repository = RepositorySpy()
        sut = NewsHeaderFacade(service, repository)
    }

    override func tearDown() {
        sut = nil
        service = nil
        repository = nil
        super.tearDown()
    }

    func testModelsEquality() {
        let newsHeader = NewsHeader(id: "02", image: "image", author: "A. Langley", title: "Bruh", articleSize: 0, content: nil)
        let newsHeaderRealm = NewsHeaderRealm(newsHeader: newsHeader)
        XCTAssertEqual(newsHeader, newsHeaderRealm.newsHeader)
    }

    func testGetDataTriggerService() {
        let expectedData = [NewsHeader(id: "02", image: "image", author: "A. Langley", title: "Bruh", articleSize: 0, content: nil)]
        var actualData = [NewsHeader]()
        service.data = expectedData
        let expectation = self.expectation(description: #function)
        sut.getNewsHeaders {
            actualData = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertEqual(repository.saveCalled, expectedData)
        XCTAssertTrue(repository.loadCalled)
        XCTAssertEqual(expectedData, actualData)
    }

    func testLoadMore() {
        let expectedData = [NewsHeader(id: "02", image: "image", author: "A. Langley", title: "Bruh", articleSize: 0, content: nil)]
        service.data = expectedData
        sut.loadMore()
        XCTAssertTrue(service.getCalled)
        XCTAssertEqual(expectedData, repository.saveCalled)
    }

    private class ServiceMock: NHService {

        var data = [NewsHeader]()
        var getCalled = false

        func getNewsHeaders(onCompletion: @escaping ([NewsHeader]) -> Void) {
            getCalled = true
            onCompletion(data)
        }

    }

    private class RepositorySpy: NHRepository {

        private let actualRepository: NewsHeaderRepository

        var saveCalled = [NewsHeader]()
        var loadCalled = false

        init() {
            let configuration = Realm.Configuration(inMemoryIdentifier: String(describing: type(of: self)))
            actualRepository = NewsHeaderRepository(config: configuration)
        }

        func save(_ data: [NewsHeader]) {
            saveCalled = data
            actualRepository.save(data)
        }

        func load() -> Results<NewsHeaderRealm> {
            loadCalled = true
            return actualRepository.load()
        }

    }

}
