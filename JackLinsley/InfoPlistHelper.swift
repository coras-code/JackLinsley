//
//  InfoPlistHelper.swift
//  Places
//
//  Created by My Apps on 12/01/2021.
//

import Foundation

class InfoPlistHelper {
    static let shared = InfoPlistHelper()
    var apiKey: String {
        get {
            
            guard let filePath = Bundle.main.path(forResource: "GooglePlaces-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Google-Info.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'GooglePlaces-Info.plist'.")
            }
         
            if (value.starts(with: "_")) {
                fatalError("Replace _ in API_KEY, in the GooglePlaces-Info.plist with your API key.")
            }
            return value
        }
    }
}


//
//static let shared = InfoPlistHelper()
// fileprivate lazy var dict: NSDictionary = {
//     var infoDictionary = NSDictionary()
//     if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
//         if let plistDictionary = NSDictionary(contentsOfFile: path) {
//             infoDictionary = plistDictionary
//         }
//     }
//     
//     return infoDictionary
// } ()
//  
// func adjustAPIKey() -> String {
//     return dict["ADJUST_API_KEY"] as! String
// }
