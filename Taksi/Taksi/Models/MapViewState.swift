//
//  MapViewState.swift
//  Taksi
//
//  Created by Kemal Aslan on 7.01.2024.
//

import Foundation
enum MapViewState {
    case noInput
    case locationSelected
    case searchingForLocation
    case polylineAdded
    case tripRequested
    case tripAccepted
    case tripRejected
    case tripCancelledByPassanger
    case tripCancelledByDriver
}
