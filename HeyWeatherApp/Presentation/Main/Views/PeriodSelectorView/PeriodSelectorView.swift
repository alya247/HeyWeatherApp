//
//  PeriodSelectorView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

enum PeriodSelectorType {
  case current
  case week
  case twoWeeks

  var title: String {
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

class PeriodSelectorView: UIView {

  @IBOutlet private var stackView: UIStackView!

  weak var delegate: SelectorDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func applySelectors( _ selectors: [PeriodSelectorType], defaultType: PeriodSelectorType = .current) {
    for selector in selectors {
      createSelector(selector, isDefault: selector == defaultType)
    }
  }

}

// MARK:- SelectorDelegate

extension PeriodSelectorView: SelectorDelegate {

  func didSelectPeriod(with type: PeriodSelectorType) {
    delegate?.didSelectPeriod(with: type)
    deselectSelectors(type)
  }
}

// MARK:- Private Methods

extension PeriodSelectorView {

  private func setup() {
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
    let contentView = nib.instantiate(withOwner: self, options: nil).first! as! UIView
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  private func createSelector(_ selector: PeriodSelectorType, isDefault: Bool) {
    let view = SelectorView(frame: .zero)
    view.apply(type: selector)
    view.delegate = self
    if isDefault {
      view.setSelected()
    }
    stackView.addArrangedSubview(view)
  }

  private func deselectSelectors(_ selectedType: PeriodSelectorType) {
    for view in stackView.arrangedSubviews {
      guard let selectorView = view as? SelectorView, selectorView.selectorType != selectedType else { continue }
      selectorView.deselect()
    }
  }

}
