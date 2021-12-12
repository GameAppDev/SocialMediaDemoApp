//
// HomeViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

protocol SetPosts{
    func setPostsProtocol(newPost:Posts)
}

class HomeViewController: UIViewController, SetPosts {

    @IBOutlet var navbarView: UIView!
    @IBOutlet var addBtnView: UIView!
    
    @IBOutlet var theTableView: UITableView!
    var identifierP:String = "PostTableViewCell"
    var postCell:PostTableViewCell?
    
    var tableCount:Int = 0
    
    var postResponse:[Posts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        tableCount = appDelegate.rootVC.orderNo
        getPostsInfo()
    }
    
    func setPostsProtocol(newPost:Posts) {
        let newOrder = appDelegate.rootVC.orderNo + 1
        UserDefaults.standard.set(newOrder, forKey: "PostOrderNo")
        UserDefaults.standard.synchronize()
        
        postResponse.append(newPost)
        theTableView.reloadData()
    }
    
    func getPostsInfo() {
        postResponse.removeAll()
        for i in (0..<tableCount) {
            let postEncoded = UserDefaults.standard.data(forKey: "PostResponse\(i)")
            let post:Posts
            do {
                post = try JSONDecoder().decode(Posts.self, from: postEncoded!)
            }
            catch let jsonErr {
                print("Decoder Error: \(jsonErr.localizedDescription)")
                return
            }
            postResponse.append(post)
        }
        theTableView.registerCell(identifier: identifierP)
        theTableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        theTableView.dataSource = self
    }
    
    @objc private func likePostClicked (sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        let userId = (appDelegate.rootVC.selectedUser?.userId)!
        postResponse[index.row].likedUsers?.append(userId)
        postResponse[index.row].likeNumber == nil ? (postResponse[index.row].likeNumber = 1) : (postResponse[index.row].likeNumber! += 1)
        theTableView.reloadData()
    }
    
    @IBAction func addPostClicked(_ sender: UIButton) {
        if appDelegate.rootVC.selectedUser == nil {
            Tools().showAlert("Please login with a user to add a post")
            return
        }
        if let controller = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "AddPostVC") as? AddPostViewController {
            controller.setPostsProtocol = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        postCell = theTableView!.dequeueReusableCell(withIdentifier: identifierP, for: indexPath) as? PostTableViewCell
        
        postCell?.profileImageView.image = UIImage(named: postResponse[indexPath.row].userPhoto)
        postCell?.usernameLabel.text = postResponse[indexPath.row].username
        postCell?.postTextLabel.text = postResponse[indexPath.row].text
        
        if postResponse[indexPath.row].photoUrl == nil {
            postCell?.postImageViewHeightC.constant = CGFloat(0)
        }
        else {
            postCell?.postImageViewHeightC.constant = CGFloat(220)
            postCell?.postImageView.image = UIImage(named: postResponse[indexPath.row].photoUrl ?? "")
        }
        
        postCell?.likeNumberLabel.text = "\(postResponse[indexPath.row].likeNumber ?? 0) Likes"
        
        if postResponse[indexPath.row].likedUsers != nil {
            for (index, _) in postResponse[indexPath.row].likedUsers!.enumerated() {
                if postResponse[indexPath.row].likedUsers?[index] == appDelegate.rootVC.selectedUser?.userId {
                    postCell?.likeButton.backgroundColor = UIColor.blue
                }
                else {
                    postCell?.likeButton.backgroundColor = UIColor.clear
                }
            }
        }

        postCell?.likeButton.addTarget(self, action: #selector(likePostClicked(sender:)), for: .touchUpInside)
        postCell?.likeButton.tag = indexPath.row
        
        return postCell!
    }
}

extension HomeViewController {
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        navbarView.addBottomShadow()
        addBtnView.setBorder(width: 2, color: UIColor.blue)
    }
}
