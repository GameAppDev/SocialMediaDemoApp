//
// RootViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Oguzhan Yalcin
//
//
//


import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var activeView: UIView!
    @IBOutlet var topSafeAreaView: UIView!
    @IBOutlet var bottomSafeAreaView: UIView!
    
    @IBOutlet var tabBarView: UIView!
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var chooseLabel: UILabel!
    @IBOutlet var notifsLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    var activeNC:UINavigationController?
    
    var selectedUser:User?
    var orderNo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        orderNo = UserDefaults.standard.integer(forKey: "PostOrderNo") 
        
        setUserInfo()
        chooseUserClicked(nil)
    }
    
    func setLabelToDefault() {
        homeLabel.textColor = UIColor.white
        searchLabel.textColor = UIColor.white
        chooseLabel.textColor = UIColor.white
        notifsLabel.textColor = UIColor.white
        messageLabel.textColor = UIColor.white
    }
    
    func setUserInfo() {
        if (UserDefaults.standard.data(forKey: "User1Response") != nil) && (UserDefaults.standard.data(forKey: "User2Response") != nil) && (UserDefaults.standard.data(forKey: "User3Response") != nil) {
            return
        }
        let user1:User = User(userId: "1", username: "Alex", profilePhotoUrl: "User1Icon", about: "Hey, I am Alex. I am Engineer")
        let user2:User = User(userId: "2", username: "Bryan", profilePhotoUrl: "User2Icon", about: "Hey, I am Bryan. I am 34 years old.")
        let user3:User = User(userId: "3", username: "Pascal", profilePhotoUrl: "User3Icon", about: "Hey, I am Pascal from Germany.")
        
        let user1Data:Data
        let user2Data:Data
        let user3Data:Data
        
        do {
            user1Data = try JSONEncoder().encode(user1)
            user2Data = try JSONEncoder().encode(user2)
            user3Data = try JSONEncoder().encode(user3)
        }
        catch let jsonErr {
            print("Encoder Error: \(jsonErr.localizedDescription)")
            return
        }
        UserDefaults.standard.set(user1Data, forKey: "User1Response")
        UserDefaults.standard.set(user2Data, forKey: "User2Response")
        UserDefaults.standard.set(user3Data, forKey: "User3Response")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func homeClicked(_ sender: UIButton?) {
        setLabelToDefault()
        if let homeNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController {
            homeLabel.textColor = UIColor.red
            
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(homeNC.view!)
            
            activeNC = homeNC
        }
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        setLabelToDefault()
        if let editProfileNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "EditProfileNC") as? UINavigationController {
            searchLabel.textColor = UIColor.red
            
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(editProfileNC.view!)
            
            activeNC = editProfileNC
        }
    }
    
    @IBAction func chooseUserClicked(_ sender: UIButton?) {
        setLabelToDefault()
        chooseLabel.textColor = UIColor.red
        if let chooseUserNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "ChooseUserNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(chooseUserNC.view!)
            
            activeNC = chooseUserNC
        }
    }
    
    @IBAction func notifsClicked(_ sender: UIButton) {
        setLabelToDefault()
        if let notifsNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "NotifsNC") as? UINavigationController {
            notifsLabel.textColor = UIColor.red
            
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(notifsNC.view!)
            
            activeNC = notifsNC
        }
    }
    
    @IBAction func messageClicked(_ sender: UIButton) {
        setLabelToDefault()
        if let messageNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "MessageNC") as? UINavigationController {
            messageLabel.textColor = UIColor.red
            
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(messageNC.view!)
            
            activeNC = messageNC
        }
    }
}
