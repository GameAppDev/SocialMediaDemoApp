//
// ChooseUserViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

class ChooseUserViewController: UIViewController {
    
    @IBOutlet var user1View: UIView!
    @IBOutlet var user1ImageView: UIImageView!
    @IBOutlet var user1Label: UILabel!
    @IBOutlet var user1AboutLabel: UILabel!
    
    @IBOutlet var user2View: UIView!
    @IBOutlet var user2ImageView: UIImageView!
    @IBOutlet var user2Label: UILabel!
    @IBOutlet var user2AboutLabel: UILabel!
    
    @IBOutlet var user3View: UIView!
    @IBOutlet var user3ImageView: UIImageView!
    @IBOutlet var user3Label: UILabel!
    @IBOutlet var user3AboutLabel: UILabel!
    
    @IBOutlet var logoutView: UIView!
    @IBOutlet var logoutLabel: UILabel!
    
    var user1Response:User?
    var user2Response:User?
    var user3Response:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        getUserInfo()
    }
    
    func getUserInfo() {
        let user1Encoded = UserDefaults.standard.data(forKey: "User1Response")
        let user2Encoded = UserDefaults.standard.data(forKey: "User2Response")
        let user3Encoded = UserDefaults.standard.data(forKey: "User3Response")
        
        do {
            user1Response = try JSONDecoder().decode(User.self, from: user1Encoded!)
            user2Response = try JSONDecoder().decode(User.self, from: user2Encoded!)
            user3Response = try JSONDecoder().decode(User.self, from: user3Encoded!)
        }
        catch let jsonErr {
            print("Decoder Error: \(jsonErr.localizedDescription)")
            return
        }
        setupViews()
    }

    @IBAction func user1Clicked(_ sender: UIButton?) {
        changeStatus(loginStatus: "1", userStatus: "1", theLabel: user1Label, theView: user1View)
        appDelegate.rootVC.selectedUser = user1Response
        (sender != nil) ? (Tools().showAlert("User Status Changed Successfully")) : ()
    }
    
    @IBAction func user2Clicked(_ sender: UIButton?) {
        changeStatus(loginStatus: "1", userStatus: "2", theLabel: user2Label, theView: user2View)
        appDelegate.rootVC.selectedUser = user2Response
        (sender != nil) ? (Tools().showAlert("User Status Changed Successfully")) : ()
    }
    
    @IBAction func user3Clicked(_ sender: UIButton?) {
        changeStatus(loginStatus: "1", userStatus: "3", theLabel: user3Label, theView: user3View)
        appDelegate.rootVC.selectedUser = user3Response
        (sender != nil) ? (Tools().showAlert("User Status Changed Successfully")) : ()
    }
    
    @IBAction func logoutClicked(_ sender: UIButton?) {
        changeStatus(loginStatus: "0", userStatus: "0", theLabel: logoutLabel, theView: logoutView)
        appDelegate.rootVC.selectedUser = nil
        (sender != nil) ? (Tools().showAlert("User Status Changed Successfully")) : ()
    }
    
    func changeStatus(loginStatus:String, userStatus:String, theLabel:UILabel, theView:UIView) {
        setViewsToDefault()
        theLabel.textColor = UIColor.red
        theView.setBorder(width: 4, color: UIColor.red)
        UserDefaults.standard.set(loginStatus, forKey: "LoginStatus")
        UserDefaults.standard.set(userStatus, forKey: "UserStatus")
        UserDefaults.standard.synchronize()
    }
    
    func setViewsToDefault() {
        user1Label.textColor = UIColor.blue
        user1View.setBorder(width: 2, color: UIColor.blue)
        user2Label.textColor = UIColor.blue
        user2View.setBorder(width: 2, color: UIColor.blue)
        user3Label.textColor = UIColor.blue
        user3View.setBorder(width: 2, color: UIColor.blue)
        logoutLabel.textColor = UIColor.blue
        logoutView.setBorder(width: 2, color: UIColor.blue)
    }
}

extension ChooseUserViewController {
    
    func setupViews() {
        user1View.setBorder(width: 2, color: UIColor.blue)
        user1View.layer.cornerRadius = CGFloat(10)
        user1ImageView.image = UIImage(named: user1Response?.profilePhotoUrl ?? "User1Icon")
        user1Label.text = user1Response?.username
        user1AboutLabel.text = user1Response?.about
        
        user2View.setBorder(width: 2, color: UIColor.blue)
        user2View.layer.cornerRadius = CGFloat(10)
        user2ImageView.image = UIImage(named: user2Response?.profilePhotoUrl ?? "User2Icon")
        user2Label.text = user2Response?.username
        user2AboutLabel.text = user2Response?.about
        
        user3View.setBorder(width: 2, color: UIColor.blue)
        user3View.layer.cornerRadius = CGFloat(10)
        user3ImageView.image = UIImage(named: user3Response?.profilePhotoUrl ?? "User3Icon")
        user3Label.text = user3Response?.username
        user3AboutLabel.text = user3Response?.about
        
        logoutView.setBorder(width: 2, color: UIColor.blue)
        logoutView.layer.cornerRadius = CGFloat(10)
        
        switch UserDefaults.standard.string(forKey: "UserStatus") {
        case "0":
            logoutClicked(nil)
            break
        case "1":
            user1Clicked(nil)
            break
        case "2":
            user2Clicked(nil)
            break
        case "3":
            user3Clicked(nil)
            break
        default:
            logoutClicked(nil)
        }
    }
}
