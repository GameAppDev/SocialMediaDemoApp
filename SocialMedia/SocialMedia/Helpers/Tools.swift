//
// Tools.swift
// SocialMedia
//
// Created on 12.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

class Tools: NSObject {
    
}

extension Tools {
    
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
}
