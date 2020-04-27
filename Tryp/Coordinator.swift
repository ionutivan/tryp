//
//  Coordinator.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/4/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {

    var childCoordinators: [Coordinator] = []
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

protocol CoordinatorInterface {

  func start()
  
}
