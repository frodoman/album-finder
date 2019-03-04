//
//  AlbumDetailsViewController_Test.swift
//  AlbumFinderUITests
//
//  Created by Xinghou Liu on 04/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest


class AlbumDetailsViewController_Test: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testInitWitCoder() {
        let detailsView = AlbumDetailsViewController(coder: NSCoder())
        XCTAssertNil(detailsView)
    }

}
