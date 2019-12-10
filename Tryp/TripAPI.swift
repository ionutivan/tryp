//
//  TripAPI.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/6/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import Foundation
import RxSwift

import Alamofire

typealias JSONObject = [String: Any]

protocol TripAPIProtocol {
    func trips() -> Observable<[Trip]>
}

class MockTripApi: TripAPIProtocol {
    
    let result: Swift.Result<[Trip], TripAPI.Errors>
    
    init(result: Swift.Result<[Trip], TripAPI.Errors>) {
        self.result = result
    }
    
    func trips() -> Observable<[Trip]> {
        return Observable.create { [weak self] observer in
            switch self?.result {
            case .success(let trips):
                observer.onNext(trips)
                observer.onCompleted()
            case .failure(let error):
                observer.onError(error)
            case .none:
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}

var baseURL: String {
    return "https://starwars.kapten.com/"
}

// MARK: - API Addresses
enum Address: CustomStringConvertible {
    case tripsList
  
    var description: String {
        switch self {
        case .tripsList: return "trips"
        }
    }

    var url: URL {
        return URL(string: baseURL.appending(description))!
    }
}

struct TripAPI: TripAPIProtocol {
    
    // MARK: - API errors
    enum Errors: Error {
        case requestFailed
        case failedJSONParsing
    }
    
    func trips() -> Observable<[Trip]> {
        return Observable.create { observer in
            let request = Alamofire.request(Address.tripsList.url)
            request.responseJSON { response in
                
                guard response.error == nil, let data = response.data else {
                        observer.onError(Errors.requestFailed)
                        return
                }
                
                guard let json = try? JSONDecoder().decode([Trip].self, from: data) else {
                    observer.onError(Errors.failedJSONParsing)
                    return
                }
                
                observer.onNext(json)
                observer.onCompleted()
            }
        
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
