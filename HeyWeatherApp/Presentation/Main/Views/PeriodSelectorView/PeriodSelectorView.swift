//
//  PeriodSelectorView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class PeriodSelectorView: UIView {

  var currentType: PeriodType = .current
  weak var delegate: SelectorDelegate?

  @IBOutlet private weak var stackView: UIStackView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialSetup()
  }

  func applySelectors( _ selectors: [PeriodType], defaultType: PeriodType = .current) {
    for selector in selectors {
      createSelector(selector, isDefault: selector == defaultType)
    }
  }

}

// MARK: - SelectorDelegate

extension PeriodSelectorView: SelectorDelegate {

  func didSelectPeriod(with type: PeriodType) {
    currentType = type
    delegate?.didSelectPeriod(with: type)
    deselectSelectors(type)
  }
}

// MARK: - Private Methods

extension PeriodSelectorView {

  private func createSelector(_ selector: PeriodType, isDefault: Bool) {
    let view = SelectorView(frame: .zero)
    view.apply(type: selector)
    view.delegate = self
    if isDefault {
      view.setSelected()
    }
    stackView.addArrangedSubview(view)
  }

  private func deselectSelectors(_ selectedType: PeriodType) {
    for view in stackView.arrangedSubviews {
      guard let selectorView = view as? SelectorView, selectorView.selectorType != selectedType else { continue }
      selectorView.deselect()
    }
  }

}
