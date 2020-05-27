//
//  MapController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 26.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet private var mapView: MKMapView!

  var locationManager: LocationManager!
  weak var delegate: MapNavigatable?

  private var clLocationManager = CLLocationManager()
  private var selectedCoordinate: CLLocationCoordinate2D?
  private var coordinate: CLLocationCoordinate2D? {
    return locationManager.selectedCoordinate == nil ? locationManager.userCoordinate
                                                     : locationManager.selectedCoordinate
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(searchWeather))

    let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLocationTap(_ :)))
    gestureRecognizer.delegate = self
    mapView.addGestureRecognizer(gestureRecognizer)

    setupMap()
  }

}

extension MapController {

  private func setupMap() {
    if CLLocationManager.locationServicesEnabled() {
      clLocationManager.delegate = self
      clLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      clLocationManager.startUpdatingLocation()
    }
  }

  @objc private func handleLocationTap(_ gestureRecognizer: UITapGestureRecognizer) {
    mapView.removeAnnotations(mapView.annotations)

    let location = gestureRecognizer.location(in: mapView)
    let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    mapView.addAnnotation(annotation)

    selectedCoordinate = coordinate
  }

  @objc private func searchWeather() {
    if let coordinate = selectedCoordinate {
      locationManager.setSelectedCoordinate(coordinate)
    }
    delegate?.reloadWeatherIfNeeded()
  }

}

extension MapController: MKMapViewDelegate { }

extension MapController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinateToShow = coordinate else { return }
    mapView.centerToLocation(CLLocation(latitude: coordinateToShow.latitude,
                                        longitude: coordinateToShow.longitude))

    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinateToShow
    mapView.addAnnotation(annotation)

  }

}

private extension MKMapView {

  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 8000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }

}
