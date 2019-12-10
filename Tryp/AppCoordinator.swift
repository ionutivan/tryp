//
//  AppCoordinator.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/4/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    func start() {
        
        let coordinator = TripListCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
