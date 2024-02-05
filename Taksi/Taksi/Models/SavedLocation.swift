//
//  SavedLocation.swift
//  Taksi
//
//  Created by Kemal Aslan on 15.01.2024.
//

import Foundation
import Firebase

struct SavedLocation:Codable {
    let title: String
    let address: String
    let coordinates: GeoPoint
    
}
