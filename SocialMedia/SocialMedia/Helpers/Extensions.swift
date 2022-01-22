//
// Extensions.swift
// SocialMedia
//
// Created on 12.12.2021.
// Oguzhan Yalcin
//
//
//


import UIKit
import AVKit
import AVFoundation

extension UIView {
    
    func setBorder(width:CGFloat, color:UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = CGFloat(4).dp
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: CGFloat(5).dp)
    }
}

extension UITableView {
    
    func registerCell(identifier:String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.tableFooterView = UIView()
        self.rowHeight = UITableView.automaticDimension
        //self.estimatedRowHeight = 100.0
        self.separatorStyle = .none
    }
}

extension CGFloat {
    
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}

extension UIViewController {
    
    func showAlert(_ mesaj:String, title:String? = "") {
        DispatchQueue.main.async(execute: {
            let app = UIApplication.shared.delegate as! AppDelegate
            let rootVC = app.window!.rootViewController as! RootViewController

            let alertCtrl = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertCtrl.addAction(action)
            
            rootVC.present(alertCtrl, animated: true, completion: nil)
        })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
