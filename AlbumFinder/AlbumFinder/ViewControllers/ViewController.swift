//
//  ViewController.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import UIKit
import AlbumSDK

final class ViewController: UIViewController {

    public var isLoading: Bool = false
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let albumService = AlbumService()
    private var viewDidAppeared: Bool = false
    private var foundAlbums: [AlbumInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !viewDidAppeared {
            _ = self.searchBar.becomeFirstResponder()
        }
        
        viewDidAppeared = true
    }
    
    //MARK: - UI
    private func setupSubviews() {
        searchBar.placeholder = "Search Albums"
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if self.isLoading {
            return
        }
        
        if let keywords = searchBar.text,
            !keywords.isEmpty {
            
            self.isLoading = true
            searchBar.resignFirstResponder()
            
            
            
            albumService.getSearchResult(withKeywords: keywords) { (result) in
                
                DispatchQueue.main.async {
                    switch result {
                    case .failed(let error):
                        print(error)
                    case .succeed(let response):
                        self.foundAlbums = response.results.albummatches?.album ?? []
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.foundAlbums.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "AlbumTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        }
        else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        var albumDetails: AlbumInfo?
        let rowIndex = indexPath.row
        if rowIndex < self.foundAlbums.count {
            albumDetails = self.foundAlbums[rowIndex]
        }
        
        if let albumInfo = albumDetails {
            cell.textLabel?.text = albumInfo.name
            cell.detailTextLabel?.text = albumInfo.artist
        }
    }
}
