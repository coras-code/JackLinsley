//
//  GymManager.swift
//  JackLinsley
//
//  Created by My Apps on 07/01/2021.
//

//import Foundation
//import CoreLocation
//
//struct GymManager {
//
//
//
//    //full place URL
//   //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=(/latitude),(/longitude)&rankby=distance&type=gym&keyword=&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI
//
//    //broken down
//    //https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&rankby=distance&location=(/latitude),(/longitude)&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI
//
//
//
//    let placesURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?rankby=distance"
//
//    let addressURL = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?rankby=distance"
//
//    let APIKey = "AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
//
//
////    https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=mongolian%20grill&inputtype=textquery
////
////    &fields=name,opening_hours,rating
////    &locationbias=circle:2000@47.6918452,-122.2226413&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI
//
//
//
//    //remember to add keyword surf in other application
//    func fetchGyms(latitude: String, longitude: String) {
//        let urlString = "\(placesURL)&location=\(latitude),\(longitude)&type=gym&key=\(APIKey)"
//        print(urlString)
//    }
//
//
//
//    func iTunesURL(searchText: String) -> URL {
//        let urlString = String(format: "https://itunes.apple.com/search?term=%@", searchText)
//        let url = URL(string: urlString)
//      return url!
//      }
//
//    func iTunesURL(searchText: String) -> URL {
//    let encodedText = searchText.addingPercentEncoding( withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//        let urlString = String(format:
//    "https://itunes.apple.com/search?term=%@", encodedText)
//
//        let url = URL(string: urlString)
//    return url!
//    }
//
//
//
//
//
//
//    func performStoreRequest(with url: URL) -> String? { do {
//    return try String(contentsOf: url, encoding: .utf8) } catch {
//    print("Download Error: \(error.localizedDescription)")
//    return nil
//    } }
//
//
//
//
//
//
////
////    func fetchGyms(address: String) {
////        let urlString = "\(placesURL)&location=\(latitude),\(longitude)&type=gym&key=\(APIKey)"
////        print(urlString)
////    }
//
//
//
//    func getCoordinate( addressString : String,
//            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
//            if error == nil {
//                if let placemark = placemarks?[0] {
//                    let location = placemark.location!
//
//                    completionHandler(location.coordinate, nil)
//                    return
//                }
//            }
//
//            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
//        }
//    }
//}

import Foundation
import CoreLocation

struct GymManager {
    
    let gymsURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&rankby=distance"
    let API_KEY = "AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
    
    func fetchNearbyGyms(latitude: String, longitude: String) {
        let urlString = "\(gymsURL)&location=\(latitude),\(longitude)&key=\(API_KEY)"
    }

}
