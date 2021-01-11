////
////  GymManager.swift
////  JackLinsley
////
////  Created by My Apps on 09/01/2021.
////
//
//import Foundation
//
//protocol GymManagerDelegate {
//    func didUpdateGyms(gyms: [GymModel])
//}
//
//struct GymManager {
//
//    var delegate: GymManagerDelegate?
//    
//    func fetchGyms(kmDistance: Double, _ latitude: String,_ longitude: String) {
//        let radius = kmDistance * 1000
//        let location = latitude + longitude
//        
//        print ("values coming into the function: \(radius) + \(location)")
//        
//        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=50.4164582,-5.100202299999978&rankby=distance&type=gym&keyword=&key=AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
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
//   func parseJSON(gymData: Data) -> [GymModel]? {
//    
//    //parse json
//    var gyms: [GymModel] = []
//    let decoder = JSONDecoder()
//    do {
//        let decodedData = try decoder.decode(Response.self, from: gymData)
//        let count = decodedData.results!.count
//        
//        if decodedData.results!.isEmpty {
//            
//        } else {
//            for index in 0..<count {
//                let name = decodedData.results![index].name
//                let rating = decodedData.results![index].rating
//                let openNow = decodedData.results![index].opening_hours?.open_now
//                
//                let gym = GymModel(name: name, rating: rating, openNow: openNow)
//                gyms.append(gym)
//            }
//            //print(gyms)
//            return gyms
//        }
//    } catch {
//        print("Error in parsing")
//    }
//        return gyms
//    }
//}
