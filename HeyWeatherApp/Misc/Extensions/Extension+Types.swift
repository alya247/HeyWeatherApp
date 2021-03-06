//
//  Extension+Types.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import CoreLocation

extension DateFormatter {

  static var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
  }

}

extension String {

  func convertedTimeZoneTime() -> String? {
    let timeZoneSeconds = TimeZone.current.secondsFromGMT()

    let dateFormatter = DateFormatter.dateFormatter

    guard let date = dateFormatter.date(from: self),
          let convertedDate = Calendar.current.date(byAdding: .second,
                                                    value: timeZoneSeconds,
                                                    to: date) else { return nil }
    return dateFormatter.string(from: convertedDate)
  }

}

extension CGFloat {

  static var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }

  static var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
  }

}

extension CLLocationCoordinate2D {

  var convertedCoordinate: String {
    return "lat: \(latitude), lon: \(longitude)"
  }

}
