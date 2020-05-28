//
//  DaysInfo.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Core

struct DaysInfo {

  var city: String? = ""
  var days: [DayInfo] = []

  init(model: WeatherDaysModel) {
    let countryCode = model.countryCode.flatMap({ ", \($0)" }) ?? ""
    self.city = model.city.flatMap({ "\($0)\(countryCode)" }) ?? ""

    for modelDay in model.days {
      let day = DayInfo(model: modelDay)
      self.days.append(day)
    }
  }

}
