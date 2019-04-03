//
//  AlbumSearchResponse.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public enum AlbumImageSize: String, Decodable {
    case small
    case medium
    case large
    case extralarge
}

public struct AlbumSearchResponse: Decodable {
    public let results: ResultDetails
}

public struct SearchAttribute: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case searchTerm = "for"
    }
    
    public var originKeywords: String
    
    public init(from decoder: Decoder) throws {
        let jsonData = try decoder.container(keyedBy: CodingKeys.self)
        originKeywords = try jsonData.decode(String.self, forKey: .searchTerm)
    }
}

public struct ResultDetails: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case attr = "@attr"
        case albummatches
    }
    
    public var query: QueryItem
    public var totalResult: Int = 0
    public var startIndex: Int = 0
    public var itemPerPage: Int = 30
    public var attr: SearchAttribute
    public var albummatches: AlbumMatchResult
    
    public init(from decoder: Decoder) throws {
        let jsonData = try decoder.container(keyedBy: CodingKeys.self)
        query = try jsonData.decode(QueryItem.self, forKey: .opensearchQuery)
        attr = try jsonData.decode(SearchAttribute.self, forKey: .attr)
        
        if let totalCountText = try? jsonData.decode(String.self, forKey:.opensearchTotalResults),
            let totalCount = Int(totalCountText) {
            totalResult = totalCount
        }

        if let indexText = try? jsonData.decode(String.self, forKey:.opensearchStartIndex),
            let index = Int(indexText) {
            startIndex = index
        }
        
        if let perPageText = try? jsonData.decode(String.self, forKey:.opensearchItemsPerPage),
            let countPerPage = Int(perPageText) {
            itemPerPage = countPerPage
        }
        
        albummatches = try jsonData.decode(AlbumMatchResult.self, forKey: .albummatches)
    }
    
}

public struct QueryItem: Decodable {
    public var role: String
    public var searchTerms: String
}

public struct AlbumMatchResult: Decodable {
    public let album:[AlbumInfo]
}

public struct AlbumInfo: Decodable {
    public let name: String
    public var artist: String
    public var url: String
    public var streamable: String
    public var mbid: String
    public var image: [AlbumImage]
}

public struct AlbumImage: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
    
    public let text: String
    public let size: AlbumImageSize
    
}

