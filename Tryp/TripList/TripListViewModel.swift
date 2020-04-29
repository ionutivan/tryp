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
    
  private let api: TripAPI
  private let bag = DisposeBag()
    
    //input
        let reload = PublishRelay<Bool>()
    
    
    //output
        let trips = PublishRelay<[Trip]>()
        let errorMessage = PublishRelay<String>()
        let selectTrip = PublishRelay<Trip?>()
    
    
    init(api: TripAPI) {
      self.api = api
    }
  
  func getTrips() {
    self.api.getTrips()
      .subscribe(onNext:{ trips in
        self.trips.accept(trips)
      }, onError: { [weak self] error in
        self?.errorMessage.accept(error.localizedDescription)
      })
    .disposed(by: bag)
  }
    
    
}
