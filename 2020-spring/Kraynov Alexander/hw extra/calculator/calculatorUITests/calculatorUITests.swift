//
//  calculatorUITests.swift
//  calculatorUITests
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import XCTest
//swiftlint:disable type_name
class calculatorUITests: XCTestCase {
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
