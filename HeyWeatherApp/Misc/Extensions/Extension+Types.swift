//
//  Extension+Types.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

extension String {

  func convertedTimeZoneTime() -> String? {
    let timeZoneSeconds = TimeZone.current.secondsFromGMT()

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"

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
