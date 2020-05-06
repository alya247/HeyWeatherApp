//
//  Extensions+UITypes.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

extension UIView {

  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }

  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable
  var borderColor: UIColor {
    get {
      return UIColor(cgColor: self.layer.borderColor!)
    }
    set {
      self.layer.borderColor = newValue.cgColor
    }
  }

}
