//
//  ViewController.swift
//  AlbumFinder
//
//  Created by Xinghou Liu on 28/02/2019.
//  Copyright © 2019 Xing Liu. All rights reserved.
//

import UIKit
import AlbumSDK
import os

final class ViewController: BaseViewController {


    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private let albumService = AlbumService()
    private var foundAlbums: [AlbumInfo] = []
    private var albumDetailsViewController: AlbumDetailsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !viewDidAppeared {
            _ = self.searchBar.becomeFirstResponder()
        }
    }
    
    //MARK: - UI
    private func setupSubviews() {
        searchBar.placeholder = "Search Albums"
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = AccessibilityIDs.mainSearhBar
        tableView.accessibilityIdentifier = AccessibilityIDs.mainTableView
    }
}


extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !self.isLoading {
            if let keywords = searchBar.text,
                !keywords.isEmpty {
                
                self.isLoading = true
                searchBar.resignFirstResponder()
                self.view.showWaitingAnimation()
                albumService.getSearchResult(withKeywords: keywords) { [weak self] (result) in
                    
                    self?.isLoading = false
                    DispatchQueue.main.async {
                        self?.view.hideWaitingAnimation()
                        switch result {
                        case .failed(let error):
                            print("Failed to get album search result: \(error)")
                        case .succeed(let response):
                            self?.foundAlbums = response.results.albummatches?.album ?? []
                            self?.tableView.reloadData()
                        }
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
        var cell : UITableViewCell?
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            cell = dequeuedCell
        }
        else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        return cell!
    }
    
    func updateUI(for indexPath: IndexPath,
                    andCell cell: UITableViewCell) {
        if let albumInfo = findAlbum(with: indexPath) {
            cell.textLabel?.text = albumInfo.name
            cell.detailTextLabel?.text = albumInfo.artist
            cell.accessibilityIdentifier = AccessibilityIDs.mainTableViewCell + ".\(indexPath.row)"
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        updateUI(for: indexPath, andCell: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let albumInfo = findAlbum(with: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let detailsViewController = AlbumDetailsViewController(with: albumInfo)
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func findAlbum(with indexPath: IndexPath) -> AlbumInfo? {
        var albumDetails: AlbumInfo?
        let rowIndex = indexPath.row
        if rowIndex < self.foundAlbums.count {
            albumDetails = self.foundAlbums[rowIndex]
        }
        return albumDetails
    }
}
