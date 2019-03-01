//
//  DefaultNetworkClient.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

internal enum NetworkErrors: Error {
    case genaric
    case unexpectedResponse
    case emptyResponse
}

public class DefaultNetworkClient: NetworkClient {
    
    public let session: NetworkSession
    
    public init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    public func makeNetworkRequest(with request: URLRequest,
                                   completion: @escaping (RequestResult<(Data)>) -> Void) {
        session.startDataTask(with: request,
                              completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                completion(.failed(error))
                return
            }
            
            
            guard let data = data else {
                completion(.failed(NetworkErrors.emptyResponse))
                return
            }
            
            completion(.succeed(data))
        })
    }
}
