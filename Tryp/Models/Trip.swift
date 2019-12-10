//
//  Trip.swift
//  Tryp
//
//  Created by Ionut Ivan on 12/5/19.
//  Copyright © 2019 Ionut Ivan. All rights reserved.
//

import Foundation

class Trip: Codable {
    let id: Int
    let duration: Double
    let pilot: Pilot
    let distance: Distance
    let pick_up: TravelPoint
    let drop_off: TravelPoint
    
    init(id: Int,
         duration: Double,
         pilot: Pilot,
         distance: Distance,
         pick_up: TravelPoint,
         drop_off: TravelPoint) {
        self.id = id
        self.duration = duration
        self.pilot = pilot
        self.distance = distance
        self.pick_up = pick_up
        self.drop_off = drop_off
    }
}

class Pilot: Codable {
    let name: String
    let avatar: String
    let rating: Double
    
    init(name: String, avatar: String, rating: Double) {
        self.name = name
        self.avatar = avatar
        self.rating = rating
    }
}

struct Distance: Codable {
    let value: Double
    let unit: String
    
    init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
}

struct TravelPoint: Codable {
    let name: String
    let picture: String
    let date: String
}
