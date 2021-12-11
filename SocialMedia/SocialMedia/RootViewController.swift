//
// RootViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Copyright (c)  Oguzhan Yalcin
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
    @IBOutlet var spacesLabel: UILabel!
    @IBOutlet var notifsLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    var homeNC:UINavigationController?
    //var homeVC:HomeViewController?
    var searchNC:UINavigationController?
    //var searchVC:HomeViewController?
    var spacesNC:UINavigationController?
    //var spacesVC:HomeViewController?
    var notifsNC:UINavigationController?
    //var notifsVC:HomeViewController?
    var messageNC:UINavigationController?
    //var messageVC:HomeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func homeClicked(_ sender: UIButton) {
    }
    @IBAction func searchClicked(_ sender: UIButton) {
    }
    @IBAction func spacesClicked(_ sender: UIButton) {
    }
    @IBAction func notifsClicked(_ sender: UIButton) {
    }
    @IBAction func messageClicked(_ sender: UIButton) {
    }
}
