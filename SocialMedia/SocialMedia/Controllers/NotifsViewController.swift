//
// NotifsViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Oguzhan Yalcin
//
//
//


import UIKit

class NotifsViewController: UIViewController {

    @IBOutlet var theLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
