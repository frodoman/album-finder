//
//  UIImageView+Common.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 02/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    // fetch an image from the network 
    public func imageFrom(urlString: String) {
        if let url = URL(string: urlString) {
        
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imgData = data, error == nil else { return }
            
                DispatchQueue.main.async() {
                    self.image = UIImage(data: imgData)
                }
            }
            task.resume()
        }
    }
}
