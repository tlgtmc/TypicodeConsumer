//
//  CommentsViewController.swift
//  tmc
//
//  Created by Tolga Atmaca on 11.03.2020.
//  Copyright © 2020 Tolga Atmaca. All rights reserved.
//

import UIKit
import TypicodeApiFramework

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var labelPostTitle: UILabel!
    @IBOutlet weak var labelPostData: UILabel!
    @IBOutlet weak var tableViewComments: UITableView!
    
    var post: Post?
    
    var comments: [Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"
        self.tableViewComments.delegate = self
        self.tableViewComments.dataSource = self
        setPostData()
        
        if NetworkHelper.isConnectedToInternet() {
            fetchComments()
        } else {
            self.tableViewComments.setEmptyTableView(false)
        }
        setPullToRefresh()
    }
    
    func setPostData() {
        labelPostTitle.text = post?.title
        labelPostData.text = post?.body
        labelPostTitle.textColor = .tmc1
    }
    
    func fetchComments() {
        self.showProgress()
        ApiCall.getComments(postId: post?.id) { apiResponse in
            switch(apiResponse.status) {
            case .success:
                self.setComments(_comments: apiResponse.responseList as! [Comment])
            case .failure:
                self.hideActiveProgress()
                self.showError("Could not get the Comment data. Please try again... Error: \(apiResponse.error)")
            }
        }
    }
    
    func setComments(_comments: [Comment]) {
        comments = _comments
        self.tableViewComments.reloadData()
        self.hideActiveProgress()
    }
    
    func setPost(_post: Post) {
        post = _post
    }
    
    
    func setPullToRefresh() {
        self.tableViewComments.refreshControl = UIRefreshControl()
        self.tableViewComments.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.tableViewComments.refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableViewComments.addSubview(self.tableViewComments.refreshControl!)
    }
    
    @objc func refresh(_ sender: Any) {
        self.tableViewComments.refreshControl?.endRefreshing()
        fetchComments()
    }
}


extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
            
        cell.labelName.text = comments[indexPath.row].name!
        cell.labelEmail.text = comments[indexPath.row].email!
        cell.labelComment.text = comments[indexPath.row].body!
        
        return cell
    }
    
}

