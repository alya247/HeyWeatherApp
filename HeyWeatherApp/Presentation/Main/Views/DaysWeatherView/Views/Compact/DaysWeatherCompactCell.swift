//
//  DaysWeatherCompactCell.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class DaysWeatherCompactCell: UICollectionViewCell {

  static let identifier = String(describing: DaysWeatherCompactCell.self)

  @IBOutlet private weak var temperatureLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  func apply(model: DayInfo, isSelected: Bool) {
    temperatureLabel.text = model.averageTemperature
    iconImageView.image = model.weatherIcon
    contentView.backgroundColor = isSelected ? .orange : .white
  }

}
