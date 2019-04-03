//
//  SearchResultScreen_Test.swift
//  AlbumFinderUITests
//
//  Created by Xinghou Liu on 03/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest

class SearchResultScreen_Test: XCTestCase {

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
    
    func testSearchKeyword_Yes() {
        
        let app = XCUIApplication()
        
        // search bar is there
        let searchBar = app.otherElements[AccessibilityIDs.mainSearhBar]
        //wait for the UI to load
        waitForElement(element: searchBar, toAppear: true)
        XCTAssertTrue(searchBar.exists)
        
        // table view is ther
        let tableView = app.tables[AccessibilityIDs.mainTableView]
        XCTAssertTrue(tableView.exists)
        
        // enter Yes into the search bar
        searchBar.typeText("Yes")
        searchBar.typeText("\n")
        
        // first table view cell should exist
        let firstCell = app.cells[AccessibilityIDs.mainTableViewCell + ".0"]
        waitForElement(element: firstCell, toAppear: true)
        XCTAssertTrue(firstCell.exists)
        
        // tap on the first cell,
        // should show the album details view
        firstCell.tap()
        
        let scrollViewsQuery = app.scrollViews
        let imageView =  scrollViewsQuery.otherElements.containing(.image, identifier:AccessibilityIDs.detailsImage).element
        waitForElement(element: imageView , toAppear: true)
        XCTAssertTrue(imageView.exists)
        
        let elementsQuery = scrollViewsQuery.otherElements
        XCTAssertTrue(elementsQuery.staticTexts[AccessibilityIDs.detailsName].exists)
        
        let buttonMoreInfo = elementsQuery.buttons[AccessibilityIDs.detailsButton]
        XCTAssertTrue(buttonMoreInfo.exists)
        buttonMoreInfo.tap()
        
        let webView = app.webViews.firstMatch
        waitForElement(element: webView, toAppear: true)
        XCTAssertNotNil(webView)
        
    }
    
    func testSearchResultTableScrolling() {

        let app = XCUIApplication()
        
        let searchBar = app.otherElements[AccessibilityIDs.mainSearhBar]
        waitForElement(element: searchBar, toAppear: true)
        XCTAssertTrue(searchBar.exists)
        
        // enter Hello into the search bar
        searchBar.typeText("Hello")
        searchBar.typeText("\n")
        
        // first table view cell should exist
        let firstCell = app.cells[AccessibilityIDs.mainTableViewCell + ".0"]
        waitForElement(element: firstCell, toAppear: true)
        XCTAssertTrue(firstCell.exists)
        
        app.swipeUp()
        let endCell = app.cells[AccessibilityIDs.mainTableViewCell + ".20"]
        scrollToElement(element: endCell)
        XCTAssertTrue(endCell.exists)
    }
    
    /*
    // uncomment this when testing on a
    // real device
     
    func testSearchWithoutNetwork() {
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settingsApp.launch()
        settingsApp.tables.cells["Airplane Mode"].tap()

        let app = XCUIApplication()
        sleep(2)
        let searchBar = app.otherElements[AccessibilityIDs.mainSearhBar]
        XCTAssertTrue(searchBar.exists)

        // enter Hello into the search bar
        searchBar.typeText("Hello")
        searchBar.typeText("\n")

        // first table view cell should exist
        let firstCell = app.cells[AccessibilityIDs.mainTableViewCell + ".0"]
        waitForElement(element: firstCell, toAppear: true)
        XCTAssertFalse(firstCell.exists)
    }
    */
}
