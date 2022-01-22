//
// DataModels.swift
// SocialMedia
//
// Created on 11.12.2021.
// Oguzhan Yalcin
//
//
//


import UIKit
import CoreLocation

struct User:Codable {
    var userId:String!
    var username:String!
    var profilePhotoUrl:String!
    var about:String?
}

struct Posts:Codable {
    var userId:String!
    var username:String!
    var userPhoto:String!
    var orderNo:Int!
    var photoUrl:String?
    var text:String?
    var createDate:String?
    var likeNumber:Int?
    var likedUsers:[String]!
}
