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
    
    private static var timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
    
    let input: Input
    let output: Output
    
    struct Input {
        let trip: PublishRelay<Trip>
    }
    
    struct Output {
        let pickUpDate: Driver<String?>
        let dropOffDate: Driver<String?>
        let tripDistance: Driver<String?>
        let tripDuration: Driver<String?>
      let pickUpPlanet: Driver<String?>
      let dropOffPlanet: Driver<String?>
      let pilotImageURL: Driver<URL?>
      let pilotName: Driver<String?>
    }
    
    init() {

        let selectTrip = PublishRelay<Trip>()
        
        let selectedTrip = selectTrip.share()
        
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
        
        let duration = selectedTrip
            .map{ TripDetailViewModel.timeFormatter.string(from: $0.duration) }
            .filter{ $0 != nil }
            .map{ "Duration: \($0!)" }
            .asDriver(onErrorJustReturn: nil)
      
      let pickUpPlanet = selectedTrip
        .map { $0.pick_up.name }
        .asDriver(onErrorJustReturn: nil)
      
      let dropOffPlanet = selectedTrip
        .map { $0.drop_off.name }
        .asDriver(onErrorJustReturn: nil)
      
      let pilotImageURL = selectedTrip
        .map { URL(string: baseURL.appending($0.pilot.avatar)) }
        .filter{ $0 != nil }
        .asDriver(onErrorJustReturn: nil)
      
      let pilotName = selectedTrip
        .map { $0.pilot.name }
        .asDriver(onErrorJustReturn: nil)
        
        self.input = Input(trip: selectTrip)
        self.output = Output(pickUpDate: pickUpDate,
                             dropOffDate: dropOffDate,
                             tripDistance: tripDistance,
                             tripDuration: duration,
                             pickUpPlanet: pickUpPlanet,
                             dropOffPlanet: dropOffPlanet,
                             pilotImageURL: pilotImageURL,
                             pilotName: pilotName)
    }
}
