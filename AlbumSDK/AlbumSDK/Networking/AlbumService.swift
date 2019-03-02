//
//  AlbumService.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public enum AlbumAccount {
    public static let apiRoot = "https://ws.audioscrobbler.com/2.0/"
    public static let apiKey = "ee24253219aeeeadb26ed0033ca1b1e2"
    public static let apiMethod = "album.search"
    public static let apiFormat = "json"
    public static let sharedSecret = "ad67b042f9d44f9f5a2dce1758be8105"
    public static let appName = "AlbumFinder"
}


public class AlbumService: ResponseHandler {
    public typealias ResponseType = AlbumSearchResponse
    
    private let client: NetworkClient

    public init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    public func getSearchResult(withKeywords keywords: String,
                    completion: @escaping (RequestResult<ResponseType>) -> Void) {
        if let url = URLFactory.makeUrl(with: keywords) {
            let request = URLRequest(url: URL(string: url)!)
            getSearchResult(with: request,
                            completion: completion)
        }
    }
    
    public func getSearchResult(with request: URLRequest,
                                completion: @escaping (RequestResult<ResponseType>) -> Void) {
        self.client.makeNetworkRequest(with: request) { (result) in
            do {
                let searchResponse: RequestResult<ResponseType> = .succeed(try self.decodeResponse(response: result))
                completion(searchResponse)
            }
            catch {
                completion(.failed(error))
            }
        }
    }
}
