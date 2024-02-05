//
//  GeoPoint.swift
//  Taksi
//
//  Created by Kemal Aslan on 15.01.2024.
//

import Firebase
import CoreLocation

extension GeoPoint{
    func toCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
