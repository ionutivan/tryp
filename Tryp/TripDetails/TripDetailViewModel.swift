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
    
    private static var isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    let input: Input
    let output: Output
    
    struct Input {
        let trip: PublishRelay<Trip>
    }
    
    struct Output {
        let trip: Driver<Trip?>
        let pickUpDate: Driver<String?>
        let dropOffDate: Driver<String?>
        let tripDistance: Driver<String?>
    }
    
    init() {

        let selectTrip = PublishRelay<Trip>()
        
        let selectedTrip = selectTrip.share()
        let sTrip = selectedTrip.map{ $0 as Trip? }.asDriver(onErrorJustReturn: nil)
        let pickUpDate = selectedTrip
            .map{ TripDetailViewModel.isoDateFormatter.date(from: $0.pick_up.date) }
            .filter{ $0 != nil }
            .map{ TripDetailViewModel.dateFormatter.string(from: $0!) }
            .asDriver(onErrorJustReturn: nil)
        
        let dropOffDate = selectedTrip
            .map{ TripDetailViewModel.isoDateFormatter.date(from: $0.drop_off.date) }
            .filter{ $0 != nil }
            .map{ TripDetailViewModel.dateFormatter.string(from: $0!) }
            .asDriver(onErrorJustReturn: nil)
        
        let distance = selectedTrip
            .map{ $0.distance.value }
            .map{ "\($0)" }
        
        let distanceUnit = selectedTrip
            .map{ $0.distance.unit }
            
        let tripDistance = Observable.zip(distance, distanceUnit) { "Distance: \($0) \($1)" }.asDriver(onErrorJustReturn: nil)
        
        self.input = Input(trip: selectTrip)
        self.output = Output(trip: sTrip, pickUpDate: pickUpDate, dropOffDate: dropOffDate, tripDistance: tripDistance)
    }
}
