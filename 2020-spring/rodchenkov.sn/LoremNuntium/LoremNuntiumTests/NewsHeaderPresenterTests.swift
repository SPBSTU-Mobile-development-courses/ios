@testable import LoremNuntium

import XCTest

class NewsHeaderPresenterTests: XCTestCase {

    private var sut: NHPresenter!
    private var facade: FacadeMock!

    override func setUp() {
        super.setUp()
        facade = FacadeMock()
        sut = NewsHeaderPresenter(facade)
    }

    override func tearDown() {
        sut = nil
        facade = nil
        super.tearDown()
    }

    func testGetTriggersLoading() {
        let expectedData = [
            NewsHeader(id: "0", image: "image0", author: "A. Langley", title: "Bruh0", articleSize: 0, content: nil)
        ]
        facade.dataInWeb = expectedData
        sut.getNewsHeaders { _ in }
        XCTAssertEqual(expectedData, facade.loadedData)
    }

    func testLoadMoreTriggersLoad() {
        let expectedData = [
            NewsHeader(id: "0", image: "image0", author: "A. Langley", title: "Bruh0", articleSize: 0, content: nil),
            NewsHeader(id: "1", image: "image1", author: "A. Langley", title: "Bruh1", articleSize: 0, content: nil)
        ]
        facade.dataInWeb = expectedData
        sut.getNewsHeaders { _ in }
        sut.loadMore()
        XCTAssertEqual(expectedData, facade.loadedData)
    }

    func testEmptyInfixFilterReturnsAll() {
        let expectedData = [
            NewsHeader(id: "0", image: "image0", author: "A. Langley", title: "Bruh0", articleSize: 0, content: nil),
            NewsHeader(id: "1", image: "image1", author: "A. Langley", title: "Bruh1", articleSize: 0, content: nil)
        ]
        facade.dataInWeb = expectedData
        sut.getNewsHeaders { _ in }
        sut.loadMore()
        let actualData = sut.filter(infix: "")
        XCTAssertEqual(expectedData, actualData)
    }

    func testLoadContentTriggersLoad() {
        let expectedData = [NewsHeader(id: "0", image: "image0", author: "A. Langley", title: "Bruh0", articleSize: 0, content: nil)]
        facade.dataInWeb = expectedData
        sut.getNewsHeaders { _ in }
        sut.loadContent(expectedData[0]) {}
        XCTAssertEqual(facade.contentLoaded, expectedData)
    }

    private class FacadeMock: NHFacade {

        var dataInWeb = [NewsHeader]()
        var loadedData = [NewsHeader]()
        var contentLoaded = [NewsHeader]()
        private var completion: (([NewsHeader]) -> Void)?

        func loadMore() {
            if let head = dataInWeb.first {
                loadedData.append(head)
                dataInWeb = Array(dataInWeb.dropFirst())
                completion?(loadedData)
            }
        }

        func getNewsHeaders(completion: @escaping ([NewsHeader]) -> Void) {
            self.completion = completion
            loadMore()
            completion(loadedData)
        }

        func loadContent(_ selectedHeader: NewsHeader, _ completion: @escaping () -> Void) {
            contentLoaded.append(selectedHeader)
        }

    }

}
