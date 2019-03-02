//
//  AlbumSearchResponse_Test.swift
//  AlbumSDKTests
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest
@testable import AlbumSDK

final class AlbumSearchResponse_Test: XCTestCase {
    func testErrorHandling() {
        if let jsonData = data(forJsonFile: "json-with-format-error") {
            let keywords = "hello"
            
            let mockClient = MockNetworkClient(session: MockNetworkSession())
            let service = AlbumService(client: mockClient)
            
            mockClient.mockedResult = .succeed(jsonData)
            
            service.getSearchResult(with: keywords) { ( result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let searchResponse):
                    XCTFail("Should be nil but got: \(searchResponse)")
                }
            }
        }
    }
}
