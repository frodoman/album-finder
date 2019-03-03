//
//  AlbumFinderUITests.swift
//  AlbumFinderUITests
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest

class AlbumFinderUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}


extension XCTestCase {
    public func waitForElement(element: XCUIElement,
                               toAppear: Bool,
                               file: String = #file,
                               line: UInt = #line) {
        var existsPredicate = NSPredicate(format: "exists == false")
        if toAppear {
            existsPredicate = NSPredicate(format: "exists == true")
        }
        let expectation = self.expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 10) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 10 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
            else {
                expectation.fulfill()
            }
        }
    }
}
