//
//  AlbumDetailsViewController.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 02/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import UIKit
import AlbumSDK

final class AlbumDetailsViewController: UIViewController {

    public let albumInfo: AlbumInfo
    
    init(with albumDetail: AlbumInfo) {
        self.albumInfo = albumDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
