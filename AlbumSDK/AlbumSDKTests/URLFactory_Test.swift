//
//  URLFactory_Test.swift
//  AlbumSDKTests
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest

@testable import AlbumSDK

final class URLFactory_Test: XCTestCase {
    
    func testUrlWithKeywords() {
        
        XCTAssertNil(URLFactory.makeUrl(with: ""))
        XCTAssertNil(URLFactory.makeUrl(with: nil))
        
        let urlString = URLFactory.makeUrl(with: "Hello")
        XCTAssertNotNil(urlString)
        
        XCTAssertTrue(urlString!.contains(AlbumAccount.apiKey))
        XCTAssertTrue(urlString!.contains(AlbumAccount.apiRoot))
        XCTAssertTrue(urlString!.contains(AlbumAccount.apiMethod))
        XCTAssertTrue(urlString!.contains(AlbumAccount.apiFormat))
    }

}
