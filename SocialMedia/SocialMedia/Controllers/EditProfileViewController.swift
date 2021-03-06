//
// EditProfileViewController.swift
// SocialMedia
//
// Created on 12.12.2021.
// Oguzhan Yalcin
//
//
//


import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var usernameTFView: UIView!
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var aboutTVView: UIView!
    @IBOutlet var aboutTV: UITextView!
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var saveBtnView: UIView!
    
    @IBOutlet var aboutTVViewHeightC: NSLayoutConstraint!
    @IBOutlet var aboutTVHeightC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        aboutTV.delegate = self
        usernameTF.delegate = self
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tapView)
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        if appDelegate.rootVC.selectedUser == nil {
            showAlert("Please login with a user")
            return
        }
        if usernameTF.text == "" {
            showAlert("Please write a username")
            return
        }
        
        let user = appDelegate.rootVC.selectedUser
        let newUser:User = User(userId: user?.userId, username: usernameTF.text, profilePhotoUrl: user?.profilePhotoUrl, about: aboutTV.text)
        
        let newUserData:Data
        do {
            newUserData = try JSONEncoder().encode(newUser)
        }
        catch let jsonErr {
            print("Encoder Error: \(jsonErr.localizedDescription)")
            return
        }
        switch UserDefaults.standard.string(forKey: "UserStatus") {
        case "1":
            UserDefaults.standard.set(newUserData, forKey: "User1Response")
            break
        case "2":
            UserDefaults.standard.set(newUserData, forKey: "User2Response")
            break
        case "3":
            UserDefaults.standard.set(newUserData, forKey: "User3Response")
            break
        default:
            break
        }
        UserDefaults.standard.synchronize()
        appDelegate.rootVC.selectedUser = newUser
        showAlert("User infos changed successfully\n\(newUser.username ?? "")")
    }
}

extension EditProfileViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count < 31
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textFieldText = textView.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + text.count
        return count < 141
    }
    
    func adjustTextViewHeight() {
        let fixedWidth = aboutTV.frame.size.width
        let newSize = aboutTV.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if newSize.height <= CGFloat(34).dp {
            aboutTVHeightC.constant = CGFloat(40).dp
            aboutTVViewHeightC.constant = CGFloat(40).dp
        }
        else if newSize.height > CGFloat(80).dp {
            aboutTVHeightC.constant = CGFloat(80).dp
            aboutTVViewHeightC.constant = CGFloat(80).dp
            aboutTV.isScrollEnabled = true
            view.layoutIfNeeded()
        }
        else {
            aboutTVHeightC.constant = newSize.height
            aboutTVViewHeightC.constant = newSize.height
            aboutTV.isScrollEnabled = false
            view.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
}


extension EditProfileViewController {
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        profileView.setBorder(width: CGFloat(2).dp, color: UIColor.blue)
        profileView.layer.cornerRadius = CGFloat(10)
        
        aboutTVView.setBorder(width: CGFloat(1).dp, color: UIColor.blue)
        usernameTFView.setBorder(width: CGFloat(1).dp, color: UIColor.blue)
        aboutTVView.layer.cornerRadius = CGFloat(10).dp
        usernameTFView.layer.cornerRadius = CGFloat(10).dp
        
        saveBtnView.layer.cornerRadius = CGFloat(10).dp
        
        aboutTVViewHeightC.constant = CGFloat(40).dp
        aboutTVHeightC.constant = CGFloat(40).dp
        if appDelegate.rootVC.selectedUser == nil {
            usernameTF.text = "User"
            aboutTV.text = "About"
            usernameTF.isUserInteractionEnabled = false
            aboutTV.isUserInteractionEnabled = false
            profileImageView.backgroundColor = UIColor.lightGray
            saveBtnView.backgroundColor = UIColor.lightGray
        }
        else {
            infoLabel.text = "* Username max 30 letters\n* About max 140 letters"
            let user = appDelegate.rootVC.selectedUser
            usernameTF.text = user?.username
            aboutTV.text = user?.about
            profileImageView.image = UIImage(named: user?.profilePhotoUrl ?? "User1Icon")
            
            aboutTVHeightC = aboutTV.heightAnchor.constraint(equalToConstant: CGFloat(40).dp)
            aboutTVHeightC.isActive = true
            adjustTextViewHeight()
        }
    }
}
