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
    
    let gymsURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&radius=1500"
        
        //i wanted gyms listed with those closest first - come back to this
//    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&rankby=distance"
    
   
    let API_KEY = "AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
    
    func fetchNearbyGyms(_ latitude: String, _ longitude: String) {
//        let urlString = "\(gymsURL)&location=\(latitude),\(longitude)&key=\(API_KEY)"
//        performRequest(urlString: urlString)
        
        //temporary
        let urlString = "\(gymsURL)&location=53.3498,6.2603&key=\(API_KEY)"
        performRequest(urlString: urlString)
        //print(urlString)
    }
    
    func fetchNearbyGyms(_ address: String) {
        //convert address to latitude and longitude
        var latitude = ""
        var longitude = ""
        
        getCoordinateFrom(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            // don't forget to update the UI from the main thread
            DispatchQueue.main.async { //do i need this if im waiting for it to continue
//                print(coordinate.latitude, coordinate.longitude) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
                latitude = String(coordinate.latitude)
                longitude = String(coordinate.longitude)
                let urlString = "\(self.gymsURL)&location=\(latitude),\(longitude)&key=\(self.API_KEY)"
                self.performRequest(urlString: urlString)
            }
        }
    }
    
    func performRequest(urlString: String) {
        let url = URL(string: urlString)
               
               guard url != nil else {
                   return
                   //log something to say what happened
               }
               
               
               let session = URLSession(configuration: .default)
               
               let task = session.dataTask(with: url!) { (data, response, error) in
                   //check for errors
                   if error == nil && data != nil {
                       
                       
                       
                       //parse json
                       let decoder = JSONDecoder()
                       do {
                           let gyms = try decoder.decode(Response.self, from: data!)
                           print("gyms:\(gyms)")
                           //print("results:\(gyms.results[0].name)")
                       } catch {
                           print("Error in parsing")
                           
                       }
                   }
               }
               //
               task.resume()
               
           }

    
    func parseJSON(gymData: Data) {
        
        //parse json
   
    }
    
    
    
    //Addtional Methods
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    
    //apple documentation way
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}



//https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&radius=1500&location=50.4164582,-5.100202299999978&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI

 //https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&radius=1500&location=53.3498,6.3106&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI

//53.3498
//6.2603
   // location=50.4164582,-5.100202299999978
