//
//  TripListViewModel.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/5/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class TripListViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let reload: PublishRelay<Bool>
    }
    
    struct Output {
        let trips: Driver<[Trip]>
        let errorMessage: Driver<String>
        let selectTrip: PublishRelay<Trip?>
    }
    
    init(api: TripAPI) {

        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Bool>()
        let selectTrip = PublishRelay<Trip?>()
        
      let trips = reloadRelay
        .flatMap { _ in
              return api.getTrips()
                      }
      
            .asDriver { (error) -> Driver<[Trip]> in
                return Driver.just([])
            }
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(trips: trips,
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"),
                             selectTrip: selectTrip)
    }
    
    
}
