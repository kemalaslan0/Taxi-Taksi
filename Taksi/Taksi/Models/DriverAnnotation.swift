//
//  DriverAnnotation.swift
//  Taksi
//
//  Created by Kemal Aslan on 15.01.2024.
//

import MapKit
import Firebase

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let uid: String
    
    init(driver:User) {
        self.uid = driver.uid
        self.coordinate = CLLocationCoordinate2D(latitude: driver.coordinate.latitude,
                                                 longitude: driver.coordinate.longitude)
    }
}
