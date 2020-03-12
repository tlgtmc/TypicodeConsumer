//
//  AlbumListTableViewController.swift
//  tmc
//
//  Created by Tolga Atmaca on 11.03.2020.
//  Copyright © 2020 Tolga Atmaca. All rights reserved.
//

import UIKit
import Toast_Swift
import TypicodeApiFramework

class AlbumListTableViewController: UITableViewController {
    
    var albumList: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        if NetworkHelper.isConnectedToInternet() {
            fetchAlbum()
        } else {
            self.tableView.setEmptyTableView(false)
        }
        setPullToRefresh()
    }
    
    func fetchAlbum() {
        self.showProgress()
        ApiCall.getAlbums() { apiResponse in
            switch(apiResponse.status) {
            case .success:
                self.albumList = apiResponse.responseList as! [Album]
                self.tableView.reloadData()
                self.hideActiveProgress()
            case .failure:
                self.hideActiveProgress()
                self.showError("Could not get the Album data. Please try again... Error: \(apiResponse.error)")
            }
        }
    }
    
    func setPullToRefresh() {
        self.refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func refresh(_ sender: Any) {
        self.refreshControl?.endRefreshing()
        fetchAlbum()
    }
}

// Tableview methods

extension AlbumListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albumList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        
        cell.labelText.text = albumList[indexPath.row].title!
        cell.imageViewAlbum.image = UIImage(named:"album")        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PhotosCollectionViewController") as! PhotosCollectionViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.setAlbumId(id: albumList[indexPath.row].id!)
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
}
