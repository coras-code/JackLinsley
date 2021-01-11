//
//  Constants.swift
//  JackLinsley
//
//  Created by My Apps on 06/01/2021.
//

//struct Constants {
struct K {
    static let alertTitle = "Find nearby gyms to a specfic location"
    static let alertMessage = ""
   // static let cellNibName = "PlacesCell"
    static let cellNibName = "GymCell" //when ive got more than one of these should they be placed in different ones
    //static let cellIdentifier = "ReusableGymCell" //need to change this in cell storyboard
    static let cellIdentifier = "ReusableCell"
    static let nearbyDistance = 1.0
    
    struct BrandColours {
        static let turquoise = "BrandTurquoise"
        static let blue = "BrandBlue"
        static let grey = "BrandGrey"
        static let navy = "BrandNavy"
        static let rose = "BrandRose"
    }
    
    struct images {
           static let homeBackground = "home_screen"
           static let filledStar = "star_icon_filled"
           static let emptyStar = "star_icon"
           static let textField = "text_field"
    }
    
    struct API {
             static let parsingError = ""
             static let baseURL = "star_icon_filled"
             static let emptyStar = "star_icon"
             static let textField = "text_field"
      }
    
//    struct NearbyGyms {
//        static let cellNibName = "GymCell"
//    }
    
    
    
    
    
}

//how to use
// replace string "" with K.BrandColours.purple
