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

  @IBOutlet private var titleLabel: UILabel!

  weak var delegate: SelectorDelegate?
  var selectorType: PeriodSelectorType = .current
  private var isSelected = false

  private let selectedColor: UIColor = .white
  private let deselectedColor: UIColor = UIColor.white.withAlphaComponent(0.4)

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
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
    let contentView = nib.instantiate(withOwner: self, options: nil).first! as! UIView
    addSubview(contentView)
    contentView.frame = bounds
    backgroundColor = deselectedColor
    layer.cornerRadius = 8
    contentView.backgroundColor = .clear
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

}
