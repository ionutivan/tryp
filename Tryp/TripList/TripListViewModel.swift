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
  private(set) var input: Input
  private(set) var output: Output
  
  struct Input {
    let reload = PublishRelay<Bool>()
  }
      
  struct Output {
    let trips = PublishRelay<[Trip]>()
    let errorMessage = PublishRelay<String>()
    let selectTrip = PublishRelay<Trip?>()
  }
        
    
    
    init(api: TripAPI) {
      self.api = api
      self.input = Input()
      self.output = Output()
    }
  
  func getTrips() {
    self.api.getTrips()
      .subscribe(onNext:{ trips in
        self.output.trips.accept(trips)
      }, onError: { [weak self] error in
        self?.output.errorMessage.accept(error.localizedDescription)
      })
    .disposed(by: bag)
  }
    
    
}
