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
        
        let jsonData = data(forJsonFile: "search-result-response-hello-normal")!
        mockClient.mockedResult = .succeed(jsonData)
        
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


        if let responseData = data(forJsonFile: "search-result-response-hello-normal") {
            
            mockSession.completionResult = (responseData, URLResponse(), nil)

            service.getSearchResult(with: "today") { ( result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let searchResponse):
                    XCTAssertNotNil(searchResponse.results.attr)
                }
            }
            
            mockSession.completionResult = (nil, URLResponse(), NetworkErrors.genaric)
            service.getSearchResult(with: "one") { ( result) in
                switch result {
                case .failed( let error):
                    XCTAssertNotNil(error)
                case .succeed(let searchResponse):
                    XCTFail("Should be nil but got: \(searchResponse)")
                }
            }
        }
    }
    
    func testWithLocalData() {
        let client = DefaultNetworkClient()
        let service = AlbumService(client: client)
        
        if let url = url(forJsonFile: "search-result-response-hello-normal") {
    
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

    func testErrorHandlers() {
        
    }
    
    func url(forJsonFile fileName: String) -> URL? {
        return Bundle(for: type(of: self).self).url(forResource: fileName, withExtension: "json")
    }
    
    func data(forJsonFile fileName: String) -> Data? {
       return Bundle(for: type(of: self).self).data(forResource: fileName, withExtension: "json")
    }
}
