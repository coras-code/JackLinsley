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
    static let placesURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    static let apiKey = "AIzaSyDQTyjE6jp4wwJRtqHWjMHbqlvHFJ-YAKI"
    static let openNow = "Open Now"
    static let closedNow = "Closed Now"
    static let coordinateSearchPlaceholder = "Search using latitude and longitude"
    static let addressSearchPlaceholder = "Search using address"
    static let latitudeTextfieldPlaceholder = "Enter Latitude"
    static let longitudeTextfieldPlaceholder = "Enter Longitude"
    static let searchButton = "Search"
    static let cancelButton = "Cancel"
   
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
        static let coordinateInput = "globe" //icon
        static let addressInput = "pencil.circle" //icon
        
    }
    
    struct API {
             static let parsingError = ""
            static let noResultsError = ""
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
