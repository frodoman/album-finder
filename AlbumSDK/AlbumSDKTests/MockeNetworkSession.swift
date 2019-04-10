//
//  MockeNetworkSession.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation
@testable import AlbumSDK

public class MockNetworkSession: NSObject, NetworkSession {
    
    public var completionResult: (Data?, URLResponse?, Error?)?
    
    public func startDataTask(with request: URLRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let completionResult = completionResult {
            completionHandler(completionResult.0, completionResult.1, completionResult.2)
        }
        
        return URLSessionDataTask()
    }
}
