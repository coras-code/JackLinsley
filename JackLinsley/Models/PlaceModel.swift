//
//  GymModel.swift
//  JackLinsley
//
//  Created by My Apps on 10/01/2021.
//

import Foundation

struct PlaceModel {
    let name: String?
    let rating: Double?
    let openNow: Bool?
    
    var openingDescription: String {
        if openNow != nil {
            return openNow! ? K.openNow : K.closedNow
            
        }
        return ""
    }
}
