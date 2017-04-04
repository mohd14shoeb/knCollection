//
//  LocationWorker.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/16/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

typealias fxLocationData = (lat: Double, long: Double)


class fxLocationWorker: NSObject, fxWorker {
    
    var responseToSuccess: ((fxLocationData) -> Void)?
    var responseToFail: ((fxError) -> Void)?
    
    init(responseToSuccess: ((fxLocationData) -> Void)?, responseToFail: ((fxError) -> Void)?) {
        self.responseToSuccess = responseToSuccess
        self.responseToFail = responseToFail
    
    }
    
    var locationManager : CLLocationManager? = CLLocationManager()
    
    func execute() {
        
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    deinit {
        print("Deinit \(NSStringFromClass(type(of: self)))")
    }
}

extension fxLocationWorker : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        
        let userLocation:CLLocation = locations[0] as CLLocation
        let longitude = userLocation.coordinate.longitude
        let latitude = userLocation.coordinate.latitude
        
        let location = fxLocationData(latitude, longitude)
        locationManager = nil 
        responseToSuccess?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let err = fxError(code: nil, message: error.localizedDescription)
        responseToFail?(err)
    }
}


