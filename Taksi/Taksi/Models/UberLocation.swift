//
//  UberLocation.swift
//  Taksi
//
//  Created by Kemal Aslan on 12.01.2024.
//

import CoreLocation

struct UberLocation: Identifiable {
    let id = NSUUID().uuidString
    let title: String
    let coordinate: CLLocationCoordinate2D
}
