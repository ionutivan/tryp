//
//  TripDetailViewController.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/8/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class TripDetailViewController: UIViewController {
    
    private var viewModel: TripDetailViewModel!
    private var trip: Trip!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var pilotNameLabel: UILabel!
    @IBOutlet weak var pilotImageView: UIImageView!
    
    convenience init(viewModel: TripDetailViewModel, trip: Trip) {
        self.init()
        self.trip = trip
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bindViews()
    }
    
    func bindViews() {
        viewModel.output.trip
            .drive(onNext: { [weak self] (trip) in
                self?.pilotNameLabel.text = trip?.pilot.name
                if let trip = trip,
                    let url = URL(string: baseURL.appending(trip.pilot.avatar)) {
                    self?.pilotImageView.kf.setImage(with: url)
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.input.trip.accept(trip)
    }
}
