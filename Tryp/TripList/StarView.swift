//
//  StarView.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/10/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

class StarView: UIView {
    
  var oneStar: UIImageView = {
    let star = UIImageView(frame: .zero)
    star.contentMode = .scaleAspectFill
    star.clipsToBounds = true
    star.image = UIImage(named: "Filled")
    star.translatesAutoresizingMaskIntoConstraints = false
    return star
  }()
  
  var twoStar: UIImageView = {
    let star = UIImageView(frame: .zero)
    star.contentMode = .scaleAspectFill
    star.clipsToBounds = true
    star.image = UIImage(named: "Filled")
    star.translatesAutoresizingMaskIntoConstraints = false
    return star
  }()

  var threeStar: UIImageView = {
    let star = UIImageView(frame: .zero)
    star.contentMode = .scaleAspectFill
    star.clipsToBounds = true
    star.image = UIImage(named: "Filled")
    star.translatesAutoresizingMaskIntoConstraints = false
    return star
  }()

  var fourStar: UIImageView = {
    let star = UIImageView(frame: .zero)
    star.contentMode = .scaleAspectFill
    star.clipsToBounds = true
    star.image = UIImage(named: "Filled")
    star.translatesAutoresizingMaskIntoConstraints = false
    return star
  }()

  var fiveStar: UIImageView = {
    let star = UIImageView(frame: .zero)
    star.contentMode = .scaleAspectFill
    star.clipsToBounds = true
    star.translatesAutoresizingMaskIntoConstraints = false
    star.image = UIImage(named: "Filled")
    return star
  }()
  
  lazy var contentStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.oneStar, self.twoStar, self.threeStar, self.fourStar, self.fiveStar])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .center
    stackView.backgroundColor = .red
    stackView.spacing = 8
    return stackView
  }()
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  func setupView() {
    backgroundColor = .clear
    self.addSubview(contentStackView)
    
    setupLayout()
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      contentStackView.heightAnchor.constraint(equalToConstant: 24),
      contentStackView.topAnchor.constraint(equalTo: topAnchor),
      contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
    
  func color(for rating: Double) {
      let images = [oneStar, twoStar, threeStar, fourStar, fiveStar]
      images.forEach { (imageView) in
          imageView.image = UIImage(named: "Empty")
      }
      for r in 0..<Int(rating) {
          images[r].image = UIImage(named: "Filled")
      }
  }
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: 24*5 + 32, height: 24)
  }
    
}
