//
//  DaysWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class DaysWeatherView: UIView {

  @IBOutlet private weak var cityLabel: UILabel!
  @IBOutlet private weak var collectionView: UICollectionView!

  private let cellSpacing: CGFloat = 5
  private let offset: CGFloat = 10
  private var days: [DayInfo] = []
  private var periodType: PeriodSelectorType = .week
  private var selectedIndex: Int?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func apply(model: DaysInfo, periodType: PeriodSelectorType) {
    selectedIndex = nil
    cityLabel.text = model.city
    days = model.days
    self.periodType = periodType
    collectionView.reloadData()
  }

  func setSelectedDay(for index: Int) {
    selectedIndex = index
    collectionView.reloadData()
  }

}

// MARK:- UICollectionViewDataSource

extension DaysWeatherView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return days.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    switch periodType {
    case .week:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCell.identifier, for: indexPath) as! DaysWeatherCell
      cell.apply(model: days[indexPath.row], isSelected: indexPath.row == selectedIndex)
      return cell

    case .twoWeeks:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCompactCell.identifier, for: indexPath) as! DaysWeatherCompactCell
      cell.apply(model: days[indexPath.row], isSelected: indexPath.row == selectedIndex)
      return cell

    default:
      return UICollectionViewCell()
    }
  }

}

// MARK:- UICollectionViewDelegateFlowLayout

extension DaysWeatherView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let divider: CGFloat = periodType == .week ? 4 : 6
    let side: CGFloat = (.screenWidth - (2 * offset) - ((divider - 1) * cellSpacing)) / divider

    return CGSize(width: side, height: side)
  }

}

// MARK:- Private Methods

extension DaysWeatherView {

  private func setup() {
    initialSetup()

    collectionView.register(UINib(nibName: DaysWeatherCell.identifier, bundle: nil),
                            forCellWithReuseIdentifier: DaysWeatherCell.identifier)
    collectionView.register(UINib(nibName: DaysWeatherCompactCell.identifier, bundle: nil),
    forCellWithReuseIdentifier: DaysWeatherCompactCell.identifier)
  }

}

