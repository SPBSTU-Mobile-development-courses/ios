//
//  PicturesUITests.swift
//  PicturesUITests
//
//  Created by Vladimir GL on 03.04.2020.
//  Copyright © 2020 VDTA. All rights reserved.
//

import XCTest

class PicturesUITests: XCTestCase {

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
