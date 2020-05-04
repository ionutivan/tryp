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
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
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
        viewModel.output.pilotImageURL
            .drive(onNext: { [weak self] url in
                if let url = url {
                    self?.pilotImageView.kf.setImage(with: url)
                }
            })
            .disposed(by: disposeBag)
        
      viewModel.output.pickUpPlanet.drive(pickUpPointPlanetLabel.rx.text).disposed(by: disposeBag)
      viewModel.output.dropOffPlanet.drive(dropOffPlanetLabel.rx.text).disposed(by: disposeBag)
      viewModel.output.pilotName.drive(pilotNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.pickUpDate.drive(pickUpDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.dropOffDate.drive(dropOffDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.tripDistance.drive(distanceLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.tripDuration.drive(durationLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.input.trip.accept(trip)
    }
}
