//
// AppDelegate.swift
// SocialMedia
//
// Created on 11.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

let appMode = "test" // test or live
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let timeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var theStoryboard:UIStoryboard!
    var rootVC:RootViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let langStr = Locale.current.languageCode
        
        if langStr != nil && langStr != "" {
            UserDefaults.standard.setValue(langStr, forKey: "LANG")
        }
        else {
            UserDefaults.standard.setValue("en", forKey: "LANG")
        }
        UserDefaults.standard.synchronize()
        
        theStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.openRoot()
        return true
    }

    func openRoot() {
        self.rootVC = self.theStoryboard.instantiateViewController(withIdentifier: "RootVC") as? RootViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.rootVC
        self.window?.makeKeyAndVisible()
    }
}

