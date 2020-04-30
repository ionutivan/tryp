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
    
    @IBOutlet weak var pilotNameLabel: UILabel!
    @IBOutlet weak var pilotImageView: UIImageView!
    @IBOutlet weak var pickUpNameLabel: UILabel!
    @IBOutlet weak var dropOffNameLabel: UILabel!
    @IBOutlet weak var starView: StarView!
    @IBOutlet weak var mainContentStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        pilotNameLabel.textColor = .white
        pickUpNameLabel.textColor = Theme.Colors.warmGreyTwo
        dropOffNameLabel.textColor = Theme.Colors.warmGreyTwo
    }
  
  func bindViewModel() {
    if let viewModel = viewModel {
      pilotNameLabel?.text = viewModel.pilotName
      dropOffNameLabel?.text = viewModel.dropOffName
      pickUpNameLabel?.text = viewModel.pickupName
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
