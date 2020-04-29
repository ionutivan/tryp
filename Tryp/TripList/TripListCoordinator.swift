//
//  TripListCoordinator.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/4/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit
import RxSwift

final class TripListCoordinator: Coordinator {
    
    let disposeBag = DisposeBag()
  
}

extension TripListCoordinator: CoordinatorInterface {
  func start() {
      let api = TripAPI()
      let viewModel = TripListViewModel(api: api)
      let viewController = TripListViewController(viewModel: viewModel)
      
      viewController.title = "LAST TRIPS"
      navigationController?.pushViewController(viewController, animated: true)
      
    viewModel.selectTrip.asDriver(onErrorJustReturn: nil).drive(onNext: { [weak self] trip in
          let coordinator = TripDetailCoordinator(navigationController: self?.navigationController, trip: trip!)
          coordinator.start()
          self?.childCoordinators.append(coordinator)
          }).disposed(by: disposeBag)
      
  }
}
