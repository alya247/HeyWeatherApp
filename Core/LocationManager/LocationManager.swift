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

public class LocationManager: NSObject, PersistenceHolder {

  public let coordinateSubject = BehaviorSubject<String?>(value: nil)
  public var userCoordinate: CLLocationCoordinate2D? {
    didSet {
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
  private var userCoordinateHandler: ((CLLocationCoordinate2D?) -> Void)?

  override public init() {
    locationManager = CLLocationManager()
    super.init()


  }

  public func requestLocation(completion: ((CLLocationCoordinate2D?) -> Void)?) {
    userCoordinateHandler = completion
    setupLocattion()
  }

  public func setSelectedCoordinate(_ coordinate: CLLocationCoordinate2D) {
    selectedCoordinate = coordinate
  }

  public func saveSelectedLocation(lat: Double, lon: Double) {
    let location = SelectedLocation(latitude: lat, longitude: lon)
    saveSelectedLocation(location, fileName: WeatherManager.PreserveKeyComponent.selectedLocation.rawValue)
  }

}

// MARK: - Private Methods

extension LocationManager {

  private func setupUserLocation() {
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.requestLocation()
    }
  }

  private func setupLocattion() {
    let fileName = WeatherManager.PreserveKeyComponent.selectedLocation.rawValue
    if let selectedLocation = getSelectedLocation(fileName: fileName) {
      userCoordinate = CLLocationCoordinate2D(latitude: selectedLocation.latitude,
                                              longitude: selectedLocation.longitude)
      userCoordinateHandler?(userCoordinate)
    } else {
      setupUserLocation()
    }
  }

}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {

  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    userCoordinate = locValue
    userCoordinateHandler?(userCoordinate)
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
