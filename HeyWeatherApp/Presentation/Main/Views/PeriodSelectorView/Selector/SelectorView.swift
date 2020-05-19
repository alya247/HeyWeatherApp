//
//  SelectorView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

protocol SelectorDelegate: class {
  func didSelectPeriod(with type: PeriodSelectorType)
}

class SelectorView: UIView {

  var selectorType: PeriodSelectorType = .current
  weak var delegate: SelectorDelegate?

  @IBOutlet private weak var titleLabel: UILabel!

  private let selectedColor: UIColor = .white
  private let deselectedColor: UIColor = UIColor.white.withAlphaComponent(0.4)
  private var isSelected = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  @IBAction private func selectPeriod(_ sender: UIButton) {
    guard !isSelected else { return }
    isSelected = !isSelected
    backgroundColor = isSelected ? selectedColor : deselectedColor
    delegate?.didSelectPeriod(with: selectorType)
  }

  func apply(type: PeriodSelectorType) {
    titleLabel.text = type.title.uppercased()
    selectorType = type
  }

  func setSelected() {
    backgroundColor = selectedColor
  }

  func deselect() {
    backgroundColor = deselectedColor
    isSelected = false
  }

}

// MARK: - Private Methods

extension SelectorView {

  private func setup() {
    initialSetup()
    backgroundColor = deselectedColor
    layer.cornerRadius = 8
  }

}
