//
//  DaysWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class DaysWeatherView: NiblessView {

  private let cityLabel = UILabel()
  private var collectionView: UICollectionView!

  private let cellSpacing: CGFloat = 5
  private let offset: CGFloat = 10
  private var days: [DayInfo] = []
  private var periodType: PeriodSelectorType = .week
  private var selectedIndex: Int?

  override init() {
    super.init()
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
    setupLabel()
    setupCollectionView()
  }

  private func setupLabel() {
    addSubview(cityLabel)
    cityLabel.layout {
      $0.trailing.equal(to: trailingAnchor, offsetBy: -20)
      $0.top.equal(to: topAnchor, offsetBy: 10)
    }
    cityLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
    cityLabel.textColor = .black
  }

  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    collectionView.register(UINib(nibName: DaysWeatherCompactCell.identifier, bundle: nil),
                            forCellWithReuseIdentifier: DaysWeatherCompactCell.identifier)
    collectionView.register(DaysWeatherCell.self, forCellWithReuseIdentifier: DaysWeatherCell.identifier)

    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear

    addSubview(collectionView)
    collectionView.layout {
      $0.leading.equal(to: leadingAnchor)
      $0.trailing.equal(to: trailingAnchor)
      $0.top.equal(to: cityLabel.bottomAnchor, offsetBy: 13)
      $0.bottom.equal(to: bottomAnchor)
    }
  }

}

