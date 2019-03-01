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
        
        let mockClient = MockNetworkClient(session: MockNetworkSession())
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
        
        mockClient.mockedResult = nil
        service.getSearchResult(with: keywords) { ( result) in
            switch result {
            case .failed( let error):
                XCTAssertNotNil(error)
            case .succeed(let searchResponse):
                 XCTFail("Should be nil but got: \(searchResponse)")
            }
        }
        
    }
    
    func testDefaultNetworkClient() {

        let mockSession = MockNetworkSession()
        let client = DefaultNetworkClient(session: mockSession)
        let service = AlbumService(client: client)


        if let responseData = Bundle(for: type(of: self).self).data(forResource: "search-result-response-hello-normal", withExtension: "json") {
            
            mockSession.completionResult = (responseData, URLResponse(), nil)

            service.getSearchResult(with: "today") { ( result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let searchResponse):
                    XCTAssertNotNil(searchResponse.results.attr)
                }
            }
            
            mockSession.completionResult = nil
            
        }
    }
    
    func testWithLocalData() {
        let client = DefaultNetworkClient()
        let service = AlbumService(client: client)
        
        if let url = Bundle(for: type(of: self).self).url(forResource: "search-result-response-hello-normal", withExtension: "json") {
    
            let request = URLRequest(url: url)
            let localdataExpectation = expectation(description: "Should Return local data")
            
            service.getSearchResult(with: request) { (result) in
                switch result {
                case .failed( let error):
                    XCTFail("Failed to load local data : \(error)")
                case .succeed(let searchResponse):
                    XCTAssertNotNil(searchResponse.results.attr)
                }
                localdataExpectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
            
        }
    }

}
