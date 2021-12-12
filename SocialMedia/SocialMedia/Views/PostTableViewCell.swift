//
// PostTableViewCell.swift
// SocialMedia
//
// Created on 12.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var postTextLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likeNumberLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var postImageViewHeightC: NSLayoutConstraint!
    
    var identifierP:String = "PostTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        postImageView.layer.cornerRadius = CGFloat(10)
        likeButton.layer.cornerRadius = likeButton.frame.height/2
        likeButton.setBorder(width: 1, color: UIColor.blue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
