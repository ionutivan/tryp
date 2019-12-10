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
        let reload: PublishRelay<Void>
        let selectTrip: PublishRelay<Trip?>
    }
    
    struct Output {
        let trips: Driver<[Trip]>
        let errorMessage: Driver<String>
        let selectedTrip: Driver<Trip?>
    }
    
    init(api: TripAPIProtocol) {

        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        let selectTrip = PublishRelay<Trip?>()
        
        let trips = reloadRelay
            .asObservable()
            .flatMapLatest({ api.trips() })
            .asDriver{ (error) -> Driver<[Trip]> in
                errorRelay.accept((error as? TripAPI.Errors)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
            }
        
        let selectedTrip = selectTrip.asDriver(onErrorJustReturn: nil)
        
        self.input = Input(reload: reloadRelay, selectTrip: selectTrip)
        self.output = Output(trips: trips,
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"),
                             selectedTrip: selectedTrip)
    }
    
    
}
