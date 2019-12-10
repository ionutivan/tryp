//
//  TripDetailViewModel.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/8/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct TripDetailViewModel {
    
    let input: Input
    let output: Output
    
    struct Input {
        let trip: PublishRelay<Trip>
    }
    
    struct Output {
        let trip: Driver<Trip?>
    }
    
    init() {

        let selectTrip = PublishRelay<Trip>()
        
        let selectedTrip = selectTrip.map({$0 as Trip}).asDriver(onErrorJustReturn: nil)
        
        self.input = Input(trip: selectTrip)
        self.output = Output(trip: selectedTrip)
    }
}
