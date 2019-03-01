//
//  AlbumService_Test.swift
//  AlbumSDKTests
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import XCTest
@testable import AlbumSDK


class AlbumService_Test: XCTestCase {

    func testWithNormalResponse() {
        let keywords = "hello"
        
        let mockClient = MockNetworkClient()
        let service = AlbumService(client: mockClient)
        
        let data = Bundle(for: type(of: self).self).data(forResource: "search-result-response-hello-normal", withExtension: "json")!
        mockClient.mockedResult = .succeed(data)
        
        service.getSearchResult(with: keywords) { ( result) in
            switch result {
            case .failed( let error):
                XCTFail("Failed to get search response: \(error)")
            case .succeed(let searchResponse):
                XCTAssertNotNil(searchResponse.results.attr)
            }
        }
        
    }

}
