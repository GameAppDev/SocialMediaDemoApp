//
// AddPostViewController.swift
// SocialMedia
//
// Created on 12.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

class AddPostViewController: UIViewController {

    @IBOutlet var navbarView: UIView!
    
    @IBOutlet var postTVView: UIView!
    @IBOutlet var postTV: UITextView!
    
    @IBOutlet var addImageBtnView: UIView!
    @IBOutlet var addImageBtnLabel: UILabel!
    @IBOutlet var addImageButton: UIButton!
    
    @IBOutlet var backBtnView: UIView!
    
    @IBOutlet var saveBtnView: UIView!
    
    var isAddImageSelected:Bool = false
    
    var setPostsProtocol: SetPosts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        postTV.delegate = self
    }
    
    func setPostInfo() {
        let user = appDelegate.rootVC.selectedUser
        let newOrderNumber:Int = appDelegate.rootVC.orderNo + 1
        var postImage:String?
        
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "dd/MMM/yyyy hh:mm"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let createDate = dateFormatter.string(from: date)
        
        (isAddImageSelected) ? (postImage = "PostImage") : (postImage = nil)
        let newPost:Posts = Posts(userId: user?.userId, username: user?.username, userPhoto: user?.profilePhotoUrl, orderNo: newOrderNumber, photoUrl: postImage, text: postTV.text, createDate: createDate, likeNumber: 0, likedUsers: nil)
        
        let newPostData:Data
        
        do {
            newPostData = try JSONEncoder().encode(newPost)
        }
        catch let jsonErr {
            print("Encoder Error: \(jsonErr.localizedDescription)")
            return
        }
        UserDefaults.standard.set(newPostData, forKey: "PostResponse\(newOrderNumber-1)")
        UserDefaults.standard.synchronize()
        
        if let delegate = self.setPostsProtocol {
            delegate.setPostsProtocol(newPost: newPost)
        }
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageClicked(_ sender: UIButton) {
        isAddImageSelected = !isAddImageSelected
        (isAddImageSelected) ? (addImageButton.backgroundColor = UIColor.blue) : (addImageButton.backgroundColor = UIColor.clear)
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        if (postTV.text == "Write Something") || (postTV.text == "") {
            Tools().showAlert("Pleasse write something")
            return
        }
        setPostInfo()
    }
}

extension AddPostViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.systemBlue
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Something"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension AddPostViewController {
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        navbarView.addBottomShadow()
        
        saveBtnView.layer.cornerRadius = CGFloat(10)
        
        postTVView.setBorder(width: 2, color: UIColor.blue)
        postTV.text = "Write Something"
        postTV.textColor = UIColor.lightGray
        
        addImageButton.setBorder(width: 2, color: UIColor.blue)
        addImageButton.layer.cornerRadius = addImageButton.frame.height/2
        backBtnView.setBorder(width: 2, color: UIColor.blue)
    }
}
