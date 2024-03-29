//
//  Response.swift
//  JackLinsley
//
//  Created by My Apps on 09/01/2021.
//

import Foundation
//WeatherData, GymData
struct Response: Codable {
    var results: [Place]? //not sure if i should make it optional
}

struct Place: Codable {
    var name: String?
    var rating: Double? = 0.0
    var opening_hours: OpeningInfo?
}

struct OpeningInfo: Codable {
    var open_now: Bool? 

//    enum CodingKeys: String, CodingKey {
//        case openNow = "open_now"
//    }
}

