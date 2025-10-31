//
//  LocationPermissionService.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 31.10.25.
//

import CoreLocation

final class LocationPermissionService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestWhenInUse() {
        manager.requestWhenInUseAuthorization()
    }

    func requestAlways() {
        manager.requestAlwaysAuthorization()
    }
}
