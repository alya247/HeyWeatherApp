//
//  NiblessCollectionViewCell.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 20.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class NiblessCollectionViewCell: UICollectionViewCell {
  
  public init() {
    super.init(frame: .zero)
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("Init is not implemented")
  }

}
