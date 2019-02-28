//
//  URLFactory.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation


public final class URLFactory {
    
    // example: for album keyword = hello
    // The return text will be:
    // http://ws.audioscrobbler.com/2.0/?method=album.search&album=hello&api_key=ee24253219aeeeadb26ed0033ca1b1e2&format=json
    public static func makeUrl(with keywords: String?) -> String? {
        var urlText: String?
        guard let searchWords = keywords,
            !searchWords.isEmpty else {
                return urlText
        }
        
        if let urlKeywords = searchWords.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlText = AlbumAccount.apiRoot + "?method=\(AlbumAccount.apiMethod)&album=\(urlKeywords)"
                      + "&api_key=\(AlbumAccount.apiKey)&format=\(AlbumAccount.apiFormat)"
        }
        
        return urlText
    }
}
