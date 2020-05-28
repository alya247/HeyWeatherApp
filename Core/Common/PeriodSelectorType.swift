//
//  PeriodSelectorType.swift
//  Core
//
//  Created by Alya Filon  on 28.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

public enum PeriodSelectorType {
  case current
  case week
  case twoWeeks

  public var title: String {
    switch self {
    case .current: return "Current"
    case .week: return "Week"
    case .twoWeeks: return "Two weeks"
    }
  }

  var daysCount: Int {
    switch self {
    case .current: return 1
    case .week: return 7
    case .twoWeeks: return 14
    }
  }
  
}
