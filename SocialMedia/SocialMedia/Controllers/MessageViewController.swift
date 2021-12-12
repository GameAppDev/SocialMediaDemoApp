//
// MessageViewController.swift
// SocialMedia
//
// Created on 11.12.2021.
// Copyright (c)  Oguzhan Yalcin
//
//
//


import UIKit

class MessageViewController: UIViewController {

    @IBOutlet var theLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
