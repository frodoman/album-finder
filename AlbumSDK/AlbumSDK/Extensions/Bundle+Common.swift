//
//  Bundle+Common.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public extension Bundle {
    
    public func data(forResource resourceName: String, withExtension resourceExtension: String) -> Data? {
        var foundData: Data?
        if let url = url(forResource: resourceName, withExtension: resourceExtension),
           let data = try? Data(contentsOf: url) {
                foundData = data
        }
        
        return foundData
    }
    
}
