//
//  NetworkClient.swift
//  AlbumSDK
//
//  Created by Xinghou Liu on 01/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation

public protocol NetworkClient {
    func makeRequest(with request: URLRequest,
                     completion: @escaping (RequestResult<(Data)>) -> Void)
}

