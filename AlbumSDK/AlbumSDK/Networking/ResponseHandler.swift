//
//  ResponseHandler.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public enum RequestResult<ResponseType> {
    case succeed(ResponseType)
    case failed(Error)
}

// MARK: - ResponseHandler

public protocol ResponseHandler {
    associatedtype ResponseType
    
    // MARK: Methods
    ///   - completion: The response data as the model object or a type representing an error value.
    func decodeResponse<ResponseType: Decodable>(response: RequestResult<Data>) throws -> ResponseType
}

public extension ResponseHandler where ResponseType: Any {
    
    public func decodeResponse<ResponseType: Decodable>(response: RequestResult<Data>) throws -> ResponseType {
        switch response {
        case .succeed(let data):
            do {
                let decodedObject = try JSONDecoder().decode(ResponseType.self, from: data)
                return decodedObject
            } catch {
                throw error
            }
            
        case .failed(let error):
            throw error
        }
    }
}
