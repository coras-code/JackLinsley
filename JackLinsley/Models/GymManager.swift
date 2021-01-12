//
//  GymManager.swift
//  JackLinsley
//
//  Created by My Apps on 11/01/2021.
//

import Foundation
import CoreLocation

protocol GymManagerDelegate {
    func didUpdateGyms(gyms: [PlaceModel])
}

struct GymManager {
    
    var delegate: GymManagerDelegate?
    
    let placesURL = K.placesURL
    //let API_Key = InfoPlistHelper.shared.adjustAPIKey()
    let API_Key = InfoPlistHelper.shared.apiKey
    
    //Coordinate Mode
    func fetchGyms(using latitide: String, _ longitude: String, withDistanceOf distanceKm: Double) {
        let radius = String(Int(distanceKm * 1000))
       
        let urlString = "\(placesURL)location=\(latitide),\(longitude)&radius=\(radius)&keyword=gym&key=\(API_Key)" //change keyword to surf in other app
        
        performRequest(urlString: urlString)
        
    }
    
    //Address Mode
    func fetchGyms(using address: String, withinDistanceOf distanceKm: Double) {
        
        getCoordinateFrom(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                self.fetchGyms(using: String(coordinate.latitude), String(coordinate.longitude), withDistanceOf: distanceKm)
                print("Here \(coordinate.latitude), \(coordinate.longitude)")
            }
        }
    }
    
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
            print("Parsing Error:\(error)")
        }
        return places
    }
    
    //MARK: - Helper Methods
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
}
