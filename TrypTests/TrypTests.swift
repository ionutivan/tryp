//
//  TrypTests.swift
//  TrypTests
//
//  Created by Ionut Ivan on 12/4/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Tryp

class TrypTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var viewModel : TripListViewModel!
    var mockApi: MockTripApi!

    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
//        let mockAPI = MockTripApi(result: Swift.Result.success([]))
        let mockAPI = MockTripApi(result: Swift.Result.failure(TripAPI.Errors.requestFailed))
        self.viewModel = TripListViewModel(api: mockAPI)
    }

    override func tearDown() {
        self.viewModel = nil
        
        super.tearDown()
    }

    func testExample() {
        mockApi = MockTripApi(result: Swift.Result.failure(TripAPI.Errors.requestFailed))
        
        // create testable observers
        let trips = scheduler.createObserver([Trip].self)
        let errorMessage = scheduler.createObserver(String.self)
        
        viewModel.output.errorMessage
            .drive(errorMessage)
            .disposed(by: disposeBag)
        
        viewModel.output.trips
            .drive(trips)
            .disposed(by: disposeBag)
        
        // when fetching the service
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        scheduler.start()
        
        // expected error message
        print("bsd")
        print(trips.events)
        
        XCTAssertEqual(errorMessage.events, [.next(10, "The operation couldn’t be completed. (Tryp.TripAPI.Errors error 0.)")])
        
    }

}
