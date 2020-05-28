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

public class LocationManager: NSObject {

  public let coordinateSubject = BehaviorSubject<String?>(value: nil)
  public var userCoordinateHandler: ((CLLocationCoordinate2D?) -> Void)?
  public var userCoordinate: CLLocationCoordinate2D? {
    didSet {
      userCoordinateHandler?(userCoordinate)
      coordinateSubject.onNext(userCoordinate?.convertedCoordinate)
    }
  }
  public var selectedCoordinate: CLLocationCoordinate2D? {
    didSet {
      coordinateSubject.onNext(selectedCoordinate?.convertedCoordinate)
    }
  }
  var shouldReloadWeather: Bool {
    return selectedCoordinate != nil
  }
  private let locationManager: CLLocationManager

  override public init() {
    locationManager = CLLocationManager()
    super.init()

    setupUserLocation()
  }

  public func setSelectedCoordinate(_ coordinate: CLLocationCoordinate2D) {
    selectedCoordinate = coordinate
  }

  private func setupUserLocation() {
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.requestLocation()
    }
  }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    userCoordinate = locValue
  }

  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }

}

extension CLLocationCoordinate2D {

  var convertedCoordinate: String {
    return "lat: \(latitude), lon: \(longitude)"
  }

}
