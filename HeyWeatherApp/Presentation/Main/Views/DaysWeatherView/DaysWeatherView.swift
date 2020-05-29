//
//  DaysWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import UI

class DaysWeatherView: NiblessView {

  private let cityLabel = UILabel()
  private var collectionView: UICollectionView!

  private let cellSpacing: CGFloat = 5
  private let offset: CGFloat = 10
  private let bag = DisposeBag()
  private var periodType: PeriodType = .week
  private var selectedIndex: Int?
  private var days = BehaviorSubject<[DayInfo]>(value: [])

  override init() {
    super.init()
    setup()
  }

  func bind(to model: Observable<(model: DaysInfo?, type: PeriodType)>) {
    days.bind(to: collectionView.rx.items) { (collectionView, index, item) -> UICollectionViewCell in
      let indexPath = IndexPath(row: index, section: 0)
      switch self.periodType {
      case .week:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCell.identifier,
                                                      for: indexPath) as! DaysWeatherCell
        cell.apply(model: item, isSelected: index == self.selectedIndex)
        return cell
      case .twoWeeks:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCompactCell.identifier,
                                                      for: indexPath) as! DaysWeatherCompactCell
        cell.apply(model: item, isSelected: index == self.selectedIndex)
        return cell
      default: return UICollectionViewCell()
      }
    }.disposed(by: bag)

    model.map { $0.0?.city }.bind(to: cityLabel.rx.text ).disposed(by: bag)

    model.subscribe(onNext: { [weak self] model in
      self?.selectedIndex = nil
      self?.periodType = model.1
      self?.setCellSize()
      self?.days.onNext(model.0?.days ?? [])
    }).disposed(by: bag)

  }

  private func setCellSize() {
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5

    let divider: CGFloat = periodType == .week ? 4 : 6
    let side: CGFloat = (.screenWidth - (2 * offset) - ((divider - 1) * cellSpacing)) / divider
    layout.itemSize = CGSize(width: side, height: side)
    layout.invalidateLayout()
  }

  func setSelectedDay(for index: Int) {
    selectedIndex = index
    collectionView.reloadData()
  }

}

// MARK: - Private Methods

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
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    collectionView.register(UINib(nibName: DaysWeatherCompactCell.identifier, bundle: nil),
                            forCellWithReuseIdentifier: DaysWeatherCompactCell.identifier)
    collectionView.register(DaysWeatherCell.self, forCellWithReuseIdentifier: DaysWeatherCell.identifier)

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
