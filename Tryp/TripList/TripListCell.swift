//
//  TripListCell.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/10/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

class TripListCell: UITableViewCell {
    
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
    
    func hideStarView() {
        mainContentStackView.removeArrangedSubview(starView)
        starView.isHidden = true
    }
    
}
