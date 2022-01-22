//
// HomeViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Oguzhan Yalcin
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
    let identifierP:String = "PostTableViewCell"
    var postCell:PostTableViewCell?
    
    var tableCount:Int = 0
    
    var postResponse:[Posts] = []
    
    var userLikes:[Int:Bool] = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        tableCount = UserDefaults.standard.integer(forKey: "PostOrderNo")
        getPostsInfo()
    }
    
    func setPostsProtocol(newPost:Posts) {
        let newOrder = appDelegate.rootVC.orderNo + 1
        UserDefaults.standard.set(newOrder, forKey: "PostOrderNo")
        UserDefaults.standard.synchronize()
        
        postResponse.append(newPost)
        
        tableCount = appDelegate.rootVC.orderNo
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
        theTableView.contentInset = UIEdgeInsets(top: CGFloat(30).dp, left: 0, bottom: 0, right: 0)
        theTableView.dataSource = self
    }
    
    @objc private func likePostClicked (sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        if let userId = appDelegate.rootVC.selectedUser?.userId {
            if userLikes[index.row] ?? false {
                postResponse[index.row].likedUsers = postResponse[index.row].likedUsers?.filter { $0 != userId }
                postResponse[index.row].likeNumber == nil ? (postResponse[index.row].likeNumber = 0) : (postResponse[index.row].likeNumber! -= 1)
                theTableView.reloadRows(at: [index], with: .right)
            }
            else {
                postResponse[index.row].likedUsers?.append(userId)
                postResponse[index.row].likeNumber == nil ? (postResponse[index.row].likeNumber = 1) : (postResponse[index.row].likeNumber! += 1)
                theTableView.reloadRows(at: [index], with: .left)
            }
            
            let editedPost:Posts = Posts(userId: postResponse[index.row].userId, username: postResponse[index.row].username, userPhoto: postResponse[index.row].userPhoto, orderNo: index.row+1, photoUrl: postResponse[index.row].photoUrl, text: postResponse[index.row].text, createDate: postResponse[index.row].createDate, likeNumber: postResponse[index.row].likeNumber, likedUsers: postResponse[index.row].likedUsers)
            
            let editedPostData:Data
            
            do {
                editedPostData = try JSONEncoder().encode(editedPost)
            }
            catch let jsonErr {
                print("Encoder Error: \(jsonErr.localizedDescription)")
                return
            }
            UserDefaults.standard.set(editedPostData, forKey: "PostResponse\(index.row)")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func addPostClicked(_ sender: UIButton) {
        if appDelegate.rootVC.selectedUser == nil {
            showAlert("Please login with a user to add a post")
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
            postCell?.postImageViewHeightC.constant = 0
        }
        else {
            postCell?.postImageViewHeightC.constant = CGFloat(220).dp
            postCell?.postImageView.image = UIImage(named: postResponse[indexPath.row].photoUrl ?? "")
        }
        
        postCell?.likeNumberLabel.text = "\(postResponse[indexPath.row].likeNumber ?? 0) Likes"
        
        userLikes[indexPath.row] = false
        postCell?.likeButton.backgroundColor = UIColor.clear
        if (postResponse[indexPath.row].likeNumber ?? 0) > 0 {
            if let likers = postResponse[indexPath.row].likedUsers {
                for (index, _) in likers.enumerated() {
                    if likers[index] == appDelegate.rootVC.selectedUser?.userId {
                        userLikes[indexPath.row] = true
                        postCell?.likeButton.backgroundColor = UIColor.blue
                    }
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
        addBtnView.setBorder(width: CGFloat(2).dp, color: UIColor.blue)
    }
}
