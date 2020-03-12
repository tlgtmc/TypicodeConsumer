//
//  UsersViewController.swift
//  tmc
//
//  Created by Tolga Atmaca on 10.03.2020.
//  Copyright © 2020 Tolga Atmaca. All rights reserved.
//

import UIKit
import Toast_Swift
import TypicodeApiFramework

class UsersTableViewController: UITableViewController {
    
    var userList: [User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NetworkHelper.isConnectedToInternet() {
            fetchUsers()
        } else {
            self.tableView.setEmptyTableView(false)
        }

        setPullToRefresh()
    }
    
    func fetchUsers() {
        self.showProgress()
        ApiCall.getUsers() { apiResponse in
            switch(apiResponse.status) {
            case .success:
                self.userList = apiResponse.responseList as! [User]
                self.tableView.reloadData()
                self.hideActiveProgress()
            case .failure:
                self.hideActiveProgress()
                self.showError("Could not get the User data. Please try again... Error: \(apiResponse.error)")
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
        fetchUsers()
    }
}

// Tableview methods

extension UsersTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.labelTitle.text = userList[indexPath.row].username!
        cell.labelSubtitle.text = userList[indexPath.row].getAddressStr()
        cell.labelFirstLetter.text = String(Array(cell.labelTitle.text!.uppercased())[0])
        cell.labelFirstLetter.textColor = .tmc1
        cell.labelTitle.textColor = .tmc3
        cell.labelSubtitle.textColor = .tmc1
        
        
        if indexPath.row % 2 != 0 {
            cell.labelFirstLetter.backgroundColor = UIColor.pastel1
        } else {
            cell.labelFirstLetter.backgroundColor = UIColor.pastel2
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        newViewController.setUser(_user: userList[indexPath.row])
        newViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let mapVC = segue.destination as? UsersMapViewController
            mapVC?.setUsers(users: self.userList)
        }
    }
}
