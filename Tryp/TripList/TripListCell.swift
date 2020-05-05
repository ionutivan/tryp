//
//  TripListCell.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/10/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

class TripListCell: UITableViewCell {
  
  var viewModel: TripCellViewModel? {
    didSet {
      bindViewModel()
    }
  }
    
  var pilotNameLabel: UILabel = {
    let pilotNameLabel = UILabel()
    pilotNameLabel.textColor = .white
    pilotNameLabel.numberOfLines = 1
    pilotNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    pilotNameLabel.translatesAutoresizingMaskIntoConstraints = false
    return pilotNameLabel
  }()
  
  var pilotImageView: UIImageView = {
    let pilotImageView = UIImageView(frame: .zero)
    pilotImageView.contentMode = .scaleAspectFill
    pilotImageView.translatesAutoresizingMaskIntoConstraints = false
    pilotImageView.clipsToBounds = true
    pilotImageView.translatesAutoresizingMaskIntoConstraints = false
    return pilotImageView
  }()
  
  var pickUpNameLabel: UILabel = {
    let pickUpNameLabel = UILabel()
    pickUpNameLabel.textColor = Theme.Colors.warmGreyTwo
    
    pickUpNameLabel.translatesAutoresizingMaskIntoConstraints = false
    return pickUpNameLabel
  }()
  
  var dropOffNameLabel: UILabel = {
    let dropOffNameLabel = UILabel()
    dropOffNameLabel.textColor = Theme.Colors.warmGreyTwo
    dropOffNameLabel.translatesAutoresizingMaskIntoConstraints = false
    return dropOffNameLabel
  }()
  
  var starView: StarView = {
    let starView = StarView()
    starView.translatesAutoresizingMaskIntoConstraints = false
    return starView
  }()
  
  lazy var mainContentStackView: UIStackView = {
    let mainContentStackView = UIStackView(arrangedSubviews: [self.pilotNameLabel, self.arrowStackView, self.starView])
    mainContentStackView.axis = .vertical
    mainContentStackView.alignment = .leading
    mainContentStackView.distribution = .fillProportionally
    mainContentStackView.spacing = 8
    mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
    return mainContentStackView
  }()
  
  var arrowImageView: UIImageView = {
    let arrowImageView = UIImageView(image: UIImage(named: "Arrow"))
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    return arrowImageView
  }()
  
  lazy var arrowStackView: UIStackView = {
    let arrowStackView = UIStackView(arrangedSubviews: [self.pickUpNameLabel, self.arrowImageView, self.dropOffNameLabel])
    arrowStackView.axis = .horizontal
    arrowStackView.distribution = .fill
    arrowStackView.alignment = .center
    arrowStackView.spacing = 8
    arrowStackView.translatesAutoresizingMaskIntoConstraints = false
    return arrowStackView
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.pilotImageView, self.mainContentStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 8
    return stackView
  }()
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  func setupView() {
    backgroundColor = .clear
    contentView.addSubview(stackView)
    setupLayout()
  }
  
  func setupLayout() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
      stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
    ])
    
    NSLayoutConstraint.activate([
      pilotImageView.widthAnchor.constraint(equalToConstant: 56),
      pilotImageView.heightAnchor.constraint(equalToConstant: 56),
      ])
  }
  
  func bindViewModel() {
    if let viewModel = viewModel {
      pilotNameLabel.text = viewModel.pilotName
      dropOffNameLabel.text = viewModel.dropOffName
      pickUpNameLabel.text = viewModel.pickupName
      if let url = viewModel.pilotImageViewURL {
        pilotImageView.kf.setImage(with: url)
      }
      
      Int(viewModel.rating) == 0 ?
        hideStarView() :
        starView.color(for: viewModel.rating)
    }
    
  }
    
    func hideStarView() {
        mainContentStackView.removeArrangedSubview(starView)
        starView.isHidden = true
    }
    
}
