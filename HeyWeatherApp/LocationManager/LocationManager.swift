//
//  LocationManager.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 26.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject {

  let coordinateSubject = BehaviorSubject<String?>(value: nil)
  var userCoordinateHandler: ((CLLocationCoordinate2D?) -> Void)?
  var userCoordinate: CLLocationCoordinate2D? {
    didSet {
      userCoordinateHandler?(userCoordinate)
      coordinateSubject.onNext(userCoordinate?.convertedCoordinate)
    }
  }
  var selectedCoordinate: CLLocationCoordinate2D? {
    didSet {
      coordinateSubject.onNext(selectedCoordinate?.convertedCoordinate)
    }
  }
  var shouldReloadWeather: Bool {
    return selectedCoordinate != nil
  }
  private let locationManager: CLLocationManager

  override init() {
    locationManager = CLLocationManager()
    super.init()

    setupUserLocation()
  }

  func setSelectedCoordinate(_ coordinate: CLLocationCoordinate2D) {
    selectedCoordinate = coordinate
  }

  private func setupUserLocation() {
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    userCoordinate = locValue
  }

}
