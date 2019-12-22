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
    @IBOutlet weak var pickUpPointPlanetLabel: UILabel!
    @IBOutlet weak var dropOffPlanetLabel: UILabel!
    @IBOutlet weak var pickUpDateLabel: UILabel!
    @IBOutlet weak var dropOffDateLabel: UILabel!
    
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
                self?.pickUpPointPlanetLabel.text = trip?.pick_up.name
                self?.dropOffPlanetLabel.text = trip?.drop_off.name
            })
            .disposed(by: disposeBag)
        
        viewModel.output.pickUpDate.drive(pickUpDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.dropOffDate.drive(dropOffDateLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.input.trip.accept(trip)
    }
}
