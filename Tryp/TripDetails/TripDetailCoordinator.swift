//
//  TripDetailCoordinator.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/8/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

final class TripDetailCoordinator: Coordinator {
    
    private var trip: Trip!
    
    init(navigationController: UINavigationController?, trip: Trip) {
        super.init(navigationController: navigationController)
        self.trip = trip
    }
    
    func start() {
        let viewModel = TripDetailViewModel()
        let viewController = TripDetailViewController(viewModel: viewModel, trip: trip)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
