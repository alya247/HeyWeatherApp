//
//  DaysWeatherCell.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class DaysWeatherCell: UICollectionViewCell {

  static let identifier = String(describing: DaysWeatherCell.self)

  @IBOutlet private weak var maxTemperatureLabel: UILabel!
  @IBOutlet private weak var minTemperatureLabel: UILabel!
  @IBOutlet private weak var windSpeedLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  func apply(model: DayInfo, isSelected: Bool) {
    maxTemperatureLabel.text = model.maxTemperature
    minTemperatureLabel.text = model.minTemperature
    windSpeedLabel.text = model.windSpeed
    iconImageView.image = model.weatherIcon
    contentView.backgroundColor = isSelected ? .orange : .white
  }
    
}
