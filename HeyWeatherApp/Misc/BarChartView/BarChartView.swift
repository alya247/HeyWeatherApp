//
//  BarChartView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

protocol BarChartSelectionInterface: class {
  func didSelectBar(for index: Int)
}

class BarChartView: UIView {

  weak var delegate: BarChartSelectionInterface?

  @IBOutlet private weak var placeholderView: UIView!

  private let spacing: CGFloat = 7
  private var values: [BarChartValues] = []

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialSetup()
  }

  func apply(values: [BarChartValues]) {
    removeBars()
    self.values = values
    createComponent()
  }

}

extension BarChartView {

  private func removeBars() {
    placeholderView.subviews.forEach { $0.removeFromSuperview() }
  }

  private func createComponent() {
    let placeholderWidth = placeholderView.bounds.width
    let placeholderHeight = placeholderView.bounds.height
    let maxValue = (values.map { $0.max }.max() ?? 1)
    let step = placeholderHeight / (maxValue == 0 ? 1 : maxValue)
    let barWidth = (placeholderWidth - CGFloat(values.count - 1) * spacing) / CGFloat(values.count)

    for (index, value) in values.enumerated() {
      let barView = BarView()
      barView.clipsToBounds = true
      barView.dayIndex = index
      barView.backgroundColor = ColorName.appOrange.color

      let barHeight = step * value.max
      let y = placeholderView.bounds.maxY - barHeight
      let x = CGFloat(index) * (barWidth + spacing)

      barView.frame.size = CGSize(width: barWidth, height: barHeight)
      barView.frame.origin = CGPoint(x: x, y: y)

      createMinComponent(in: barView, value: value)
      addTarget(to: barView)
      placeholderView.addSubview(barView)
    }
  }

  private func createMinComponent(in bar: BarView, value: BarChartValues) {
    let minComponent = UIView()
    minComponent.isUserInteractionEnabled = false
    minComponent.backgroundColor = .lightGray

    let heightDivider = value.max * value.min <= 0 ? 1 : value.max * value.min
    let height = bar.bounds.height / heightDivider
    let y = bar.frame.maxY - height > bar.frame.maxY ? bar.frame.maxY - 2 : bar.frame.maxY - height
    let origin = CGPoint(x: 0, y: y)
    minComponent.frame = CGRect(origin: origin,
                                size: CGSize(width: bar.bounds.width, height: height))
    bar.addSubview(minComponent)
  }

  private func addTarget(to bar: BarView) {
    let tap = UITapGestureRecognizer(target: self, action: #selector(barDidSelected(_: )))
    bar.addGestureRecognizer(tap)
  }

  @objc private func barDidSelected(_ sender: UITapGestureRecognizer) {
    guard let bar = sender.view as? BarView else { return }
    delegate?.didSelectBar(for: bar.dayIndex)
  }

}

class BarView: UIView {
  var dayIndex: Int = 0
}
