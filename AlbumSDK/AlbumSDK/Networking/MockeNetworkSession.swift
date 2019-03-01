//
//  MockeNetworkSession.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public class MockNetworkSession: NSObject, NetworkSession {
    
    public var completionResult: (Data?, URLResponse?, Error?)?
    
    public func startDataTask(with request: URLRequest,
                              completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        guard let completionResult = completionResult else {
            fatalError("No completion handler set")
        }
        
        completionHandler(completionResult.0, completionResult.1, completionResult.2)
        
        return URLSessionDataTask()
    }
}
