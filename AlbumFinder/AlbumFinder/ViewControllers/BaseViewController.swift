//
//  BaseViewController.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 02/03/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

    public var viewDidAppeared: Bool = false
    public var isLoading: Bool = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppeared = true
    }

}
