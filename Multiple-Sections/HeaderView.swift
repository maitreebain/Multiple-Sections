//
//  HeaderView.swift
//  Multiple-Sections
//
//  Created by Maitree Bain on 8/18/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
  public var textLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    textLabelConstraints()
  }
  
  private func textLabelConstraints() {
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
    ])
  }
}
