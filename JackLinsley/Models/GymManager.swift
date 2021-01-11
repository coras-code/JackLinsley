//
//  GymManager.swift
//  JackLinsley
//
//  Created by My Apps on 11/01/2021.
//

import Foundation

protocol GymManagerDelegate {
    func didUpdateGyms(gyms: [PlaceModel])
}

struct GymManager {
    
    var delegate: GymManagerDelegate?
    
    let placesURL =
    "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=gym&radius=1500"
    
    let API_Key = "AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
    
    func fetchGyms(kmDistance: Double,_ latitide: String,_ longitude: String) {
        let radius = String(Int(kmDistance * 1000))
        print("radius: \(radius)")
        //working URL - however wrong search
        //let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&radius=1000&keyword=gym&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
        
        //URL works in browser
        //let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&radius=1000&keyword=gym&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
        
        let urlString = "\(placesURL)location=\(latitide),\(longitude)&radius=\(radius)&keyword=gym&key=\(API_Key)" //change keyword to surf in other app
        
        performRequest(urlString: urlString)
        
        //returns:
        // https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&radius=1000&keyword=gym&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI
        
        
    } //added
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let places = self.parseJSON(placesData: data!) {
                    self.delegate?.didUpdateGyms(gyms: places) //the only issue with this is if i reused this manager everywhere for different requests, it will alway update the gyms
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(placesData: Data) -> [PlaceModel]? {
        var places: [PlaceModel] = []
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Response.self, from: placesData)
            let count = decodedData.results!.count
            
            if !(decodedData.results!.isEmpty) {
                for index in 0..<count {
                let name = decodedData.results![index].name
                let rating = decodedData.results![index].rating
                let openNow = decodedData.results![index].opening_hours?.open_now
                
                let place = PlaceModel(name: name, rating: rating, openNow: openNow)
                places.append(place)
                print(decodedData)
                }
            } else {
                print("No results returned")
            }
        } catch {
            print(error)
        }
        return places
    }
    
    
    
    //        let url = URL(string: urlString)
    //
    //        guard url != nil else {
    //            return
    //            //log something to say what happened
    //        }
    //
    //
    //        let session = URLSession(configuration: .default)
    //
    //        let task = session.dataTask(with: url!) { (data, response, error) in
    //
    //            if error == nil && data != nil {//check for errors
    //
    //                if let gyms = self.parseJSON(gymData: data!) {
    //                    self.delegate?.didUpdateGyms(gyms: gyms)
    //                }
    //            }
    //        }
    //        //
    //        task.resume()
    //
    //
    //    }
    //
    //    func parseJSON(gymData: Data) -> [GymModel]? {
    //
    //        //parse json
    //        var gyms: [GymModel] = []
    //        let decoder = JSONDecoder()
    //        do {
    //            let decodedData = try decoder.decode(Response.self, from: gymData)
    //            let count = decodedData.results!.count
    //
    //            if decodedData.results!.isEmpty {
    //
    //            } else {
    //                for index in 0..<count {
    //                    let name = decodedData.results![index].name
    //                    let rating = decodedData.results![index].rating
    //                    let openNow = decodedData.results![index].opening_hours?.open_now
    //
    //                    let gym = GymModel(name: name, rating: rating, openNow: openNow)
    //                    gyms.append(gym)
    //                }
    //                //print(gyms)
    //                return gyms
    //            }
    //        } catch {
    //            print("Error in parsing")
    //        }
    //        return gyms
    //    }
}
