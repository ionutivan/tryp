//
//  StarView.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/10/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    @IBOutlet weak var oneStar: UIImageView!
    @IBOutlet weak var twoStar: UIImageView!
    @IBOutlet weak var threeStar: UIImageView!
    @IBOutlet weak var fourStar: UIImageView!
    @IBOutlet weak var fiveStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    func color(for rating: Double) {
        let images = [oneStar, twoStar, threeStar, fourStar, fiveStar]
        images.forEach { (imageView) in
            imageView?.image = UIImage(named: "Empty")
        }
        for r in 0..<Int(rating) {
            images[r]?.image = UIImage(named: "Filled")
        }
    }
    
}
