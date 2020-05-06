//
//  BarChartView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

typealias BarChartValue = (max: CGFloat, min: CGFloat)

protocol BarChartSelectionInterface: class {
  func didSelectBar(for index: Int)
}

class BarChartView: UIView {

  @IBOutlet private var placeholderView: UIView!

  weak var delegate: BarChartSelectionInterface?

  private var values: [BarChartValue] = []
  private let spacing: CGFloat = 7

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func apply(values: [BarChartValue]) {
    removeBars()
    self.values = values
    createComponent()
  }

}

extension BarChartView {

  private func setup() {
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
    let contentView = nib.instantiate(withOwner: self, options: nil).first! as! UIView
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

  private func removeBars() {
    placeholderView.subviews.forEach { $0.removeFromSuperview() }
  }

  private func createComponent() {
    let placeholderWidth = placeholderView.bounds.width
    let placeholderHeight = placeholderView.bounds.height
    let step = placeholderHeight / (values.map { $0.max }.max() ?? 1)
    let barWidth = (placeholderWidth - CGFloat(values.count - 1) * spacing) / CGFloat(values.count)

    for (index, value) in values.enumerated() {
      let barView = BarView()
      barView.dayIndex = index
      barView.backgroundColor = .orange

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

  private func createMinComponent(in bar: BarView, value: BarChartValue) {
    let minComponent = UIView()
    minComponent.isUserInteractionEnabled = false
    minComponent.backgroundColor = .lightGray

    let height = bar.bounds.height / value.max * value.min
    let origin = CGPoint(x: 0, y: bar.bounds.maxY - height)
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
