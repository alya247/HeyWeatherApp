//
//  DaysWeatherCell.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class DaysWeatherCell: NiblessCollectionViewCell {

  static let identifier = String(describing: DaysWeatherCell.self)

  private var maxTemperatureLabel = UILabel()
  private var minTemperatureLabel = UILabel()
  private var windSpeedLabel = UILabel()
  private var iconImageView = UIImageView()

  override init() {
    super.init()
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func apply(model: DayInfo, isSelected: Bool) {
    maxTemperatureLabel.text = model.maxTemperature
    minTemperatureLabel.text = model.minTemperature
    windSpeedLabel.text = model.windSpeed
    iconImageView.image = model.weatherIcon
    contentView.backgroundColor = isSelected ? ColorName.appOrange.color : .white
  }
    
}

extension DaysWeatherCell {

  private func setup() {
    contentView.cornerRadius = 15
    setupImageView()
    setupMaxTemperatureLabel()
    setupMinTemperatureLabel()
    setupWindSpeedLabel()
  }

  private func setupImageView() {
    addSubview(iconImageView)
    iconImageView.layout {
      $0.top.equal(to: topAnchor, offsetBy: 8)
      $0.trailing.equal(to: trailingAnchor, offsetBy: -5)
      $0.width.equal(to: 30)
      $0.height.equal(to: 30)
    }
    iconImageView.contentMode = .scaleAspectFit
  }

  private func setupMaxTemperatureLabel() {
    addSubview(maxTemperatureLabel)
    maxTemperatureLabel.layout {
      $0.leading.equal(to: leadingAnchor, offsetBy: 5)
      $0.top.equal(to: topAnchor, offsetBy: 8)
      $0.trailing.greaterThanOrEqual(to: iconImageView.leadingAnchor, offsetBy: 5)
    }
    setLabelFont(for: maxTemperatureLabel)
  }

  private func setupMinTemperatureLabel() {
    addSubview(minTemperatureLabel)
    minTemperatureLabel.layout {
      $0.leading.equal(to: leadingAnchor, offsetBy: 5)
      $0.top.equal(to: maxTemperatureLabel.bottomAnchor, offsetBy: 8)
      $0.trailing.greaterThanOrEqual(to: iconImageView.leadingAnchor, offsetBy: 5)
    }
    setLabelFont(for: minTemperatureLabel)
  }

  private func setupWindSpeedLabel() {
    addSubview(windSpeedLabel)
    windSpeedLabel.layout {
      $0.leading.greaterThanOrEqual(to: leadingAnchor, offsetBy: 5)
      $0.bottom.equal(to: bottomAnchor, offsetBy: -5)
      $0.trailing.equal(to: trailingAnchor, offsetBy: -5)
    }
    setLabelFont(for: windSpeedLabel)
  }

  private func setLabelFont(for label: UILabel) {
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.textColor = .black
  }

}
