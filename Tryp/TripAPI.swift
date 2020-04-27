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
    func getTrips() -> Observable<[Trip]>
}

class MockTripApi: TripAPIProtocol {
    
    let result: Swift.Result<[Trip], TripAPI.Errors>
    
    init(result: Swift.Result<[Trip], TripAPI.Errors>) {
        self.result = result
    }
    
    func getTrips() -> Observable<[Trip]> {
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
  
  func getTrips() -> Observable<[Trip]> {
    return buildRequest(url: Address.tripsList.url)
      .map { data in
        let decoder = JSONDecoder()
        do {
          let trips = try decoder.decode([Trip].self, from: data)
          return trips
        } catch {
          throw Errors.failedJSONParsing
        }
    }
  }
  
  func buildRequest(url: URL) -> Observable<Data> {
    let request: Observable<URLRequest> = Observable.create() { observer in
      var request = URLRequest(url: url)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      observer.onNext(request)
      observer.onCompleted()
      
      return Disposables.create()
    }
    
    let session = URLSession.shared
    return request.flatMap() { request in
      return session.rx.response(request: request).map() { response, data in
        switch response.statusCode {
        case 200 ..< 300:
          return data
        default:
          throw Errors.requestFailed
        }
      }
    }
  }
    
}
