//
//  User.swift
//  Taksi
//
//  Created by Kemal Aslan on 14.01.2024.
//
import Firebase


enum AccountType: Int, Codable {
    case passenger
    case driver
}

struct User:Codable {
    let fullName:String
    let email:String
    let uid: String
    var coordinate: GeoPoint
    var accountType: AccountType
    var homeLocation: SavedLocation?
    var workLocation: SavedLocation?
}
