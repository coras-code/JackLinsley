//
//  NearbyGymsViewController.swift
//  JackLinsley
//
//  Created by My Apps on 31/12/2020.
//

import UIKit

class NearbyGymsViewController : UITableViewController {
    
    var coordinateMode = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    let gyms = [
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: false),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: false),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: false),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true)
    ]
    
    override func viewDidLoad() {
        searchBar.delegate = self
        modeSelection(coordinateModeEnabled: coordinateModeEnabled)
    }
    
    func modeSelection(coordinateModeEnabled: Bool) {
        if coordinateModeEnabled {
            barButton.image =  UIImage(systemName: "globe")
            searchBar.placeholder = "Search using latitude and longitude"
            } else {
            //addressModeEnabled:
            barButton.image =  UIImage(systemName: "pencil.circle")
            searchBar.placeholder = "Search using address"
                
            }
        }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GymCell", for: indexPath)
        
        cell.selectionStyle = .none
        
        // Linking cell in view to controller - create a new CELL subclass
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let openingHoursLabel = cell.viewWithTag(100) as! UILabel
        let imagePosition1 = cell.viewWithTag(1) as! UIImageView
        let imagePosition2 = cell.viewWithTag(2) as! UIImageView
        let imagePosition3 = cell.viewWithTag(3) as! UIImageView
        let imagePosition4 = cell.viewWithTag(4) as! UIImageView
        let imagePosition5 = cell.viewWithTag(5) as! UIImageView
        
        //setting up cell
        nameLabel.text = gyms[indexPath.row].name
        openingHoursLabel.text = gyms[indexPath.row].openingHours ? "Open Now" : "Closed Now"
        openingHoursLabel.textColor = gyms[indexPath.row].openingHours ? UIColor.black : UIColor.red
        
        let rating = gyms[indexPath.row].rating
        let ratingPositions = [imagePosition1, imagePosition2, imagePosition3, imagePosition4, imagePosition5]
        
        for (index, position) in ratingPositions.enumerated() {
            position.image = index < rating ? UIImage(named: "star_icon_filled") : UIImage(named: "star_icon")
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.allowsSelection = false
        
    }
    
    //MARK: - Bar Button Item
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) { //this changes the mode
        coordinateModeEnabled = !coordinateModeEnabled
        modeSelection(coordinateModeEnabled: coordinateModeEnabled)
        searchBar.text = ""// clear the search bar
        searchBar.resignFirstResponder()
        //clear table view?
        //replace tableview with current location date, to show this have a filled location
    }
}

//MARK: - Search Bar Methods
extension NearbyGymsViewController: UISearchBarDelegate {
    //let coordinates = "" // for API
    
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        //right now there is no indication of what is the tableview, so this method is a bad idea
//        //however if there was a map and it displayed where the data is from, i could have this function
//        //only applies to address as the coordinate mode is never begins editing
//        searchBar.text = ""
//    }
//
    //Address Mode Input
    //would use 'Did end editing method' here if you can search in two places e.g. a search button and the search on the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchBar.text //INPUT
        print(searchBar.text!)
        barButton.isEnabled = true
        searchBar.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        //this means the user can exit unless they enter something - allow them to have an exit - tap gesture (tapping out side the keyboard??)
        if searchBar.text != "" {
            return true
        } else {
            searchBar.shake()
           // searchBar.resignFirstResponder() //or end editing??
            return false
        }
    }
    
    //Coordinate Mode Input
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if coordinateModeEnabled {
            coordinateEntry()
            return false
        } else {
            barButton.isEnabled = false
            return true
            
        }
    }
    
    func coordinateEntry() {
        var latitudeTextField = UITextField()
        var longitudeTextField = UITextField()
        
        let alert = UIAlertController(title: K.alertTitle, message: K.alertMessage, preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Latitude" //K.latitudeTextFieldPlaceholder
            alertTextField.keyboardType = .numberPad
            alertTextField.addNumericAccessory()
            latitudeTextField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Longitude" //K.longitudeTextFieldPlaceholder
            alertTextField.keyboardType = .numberPad
            alertTextField.addNumericAccessory()
            longitudeTextField = alertTextField
            
        }
        
        let action = UIAlertAction(title: "Search Gyms", style: .default) { (action) in
            //Result of action button pressed
            if latitudeTextField.text != "", longitudeTextField.text != "" {
                if let latitide = latitudeTextField.text, let longitude = longitudeTextField.text {
                    self.gymManager.fetchGyms(latitude: latitide, longitude: longitude)
                }
                
                self.searchBar.searchTextField.text = "\(latitudeTextField.text!); \(longitudeTextField.text!)" //API INPUT
                
            } else {self.searchBar.shake()}
            
            //can force unwrap because a textfield can never be nil - just an empty string
           //need to deal with empty strings: one and other, maybe a shake and says enter both
            //loading cell appears //then tabledata reloads with new info
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            //Result of cancel button pressed
            //pass "" in to lat and long how does this affect api
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        //latitudeTextField.text! //longitudeTextField.text! - this needs to be passed in as an input
    }
    
}







//alternate for the cel? delete if dont use?
class GymCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel! //naming check, also check constriaints and colours and refactoring
    
    @IBOutlet weak var openingHoursLabel: UILabel!
    
    @IBOutlet weak var ratingPosition1: UIImageView! //make this a class
    @IBOutlet weak var ratingPosition2: UIImageView!
    @IBOutlet weak var ratingPosition3: UIImageView!
    @IBOutlet weak var ratingPosition4: UIImageView!
    @IBOutlet weak var ratingPosition5: UIImageView!
}


extension UITextField {

func addNumericAccessory() {
    let numberToolbar = UIToolbar()
    numberToolbar.barStyle = UIBarStyle.default

    var accessories : [UIBarButtonItem] = []

    accessories.append(UIBarButtonItem(title: "+/-", style: UIBarButtonItem.Style.plain, target: self, action: #selector(plusMinusPressed)))
    accessories.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
    accessories.append(UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(numberPadDone)))

    numberToolbar.items = accessories
    numberToolbar.sizeToFit()

    inputAccessoryView = numberToolbar
}

@objc func numberPadDone() {
    self.resignFirstResponder()
}

@objc func plusMinusPressed() {
    guard let currentText = self.text else {
        return
    }
    if currentText.hasPrefix("-") {
        let offsetIndex = currentText.index(currentText.startIndex, offsetBy: 1)
        let substring = currentText[offsetIndex...]  //remove first character
        self.text = String(substring)
    }
    else {
        self.text = "-" + currentText
    }
}

}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
