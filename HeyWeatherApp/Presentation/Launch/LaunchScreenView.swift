//
//  LaunchScreenView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class LaunchScreenView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  private func setup() {
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
    let contentView = nib.instantiate(withOwner: self, options: nil).first! as! UIView
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

}
