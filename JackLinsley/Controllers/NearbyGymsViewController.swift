//
//  NearbyGymsViewController.swift
//  JackLinsley
//
//  Created by My Apps on 31/12/2020.
//

import UIKit

class NearbyGymsViewController : UITableViewController {
    
    var coordinateMode = true
    
    //need a strings class
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        //if coordinateMode {
       //     searchBar.isUserInteractionEnabled = false
     
            
      //  }
          
    }
    
    //Mark: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GymCell", for: indexPath)
        
        cell.selectionStyle = .none
        
       // Linking cell in view to controller - create a new CELL subclass
        let nameLabel = cell.viewWithTag(1000) as! UILabel //should it be a var
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
    
    //Mark: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       tableView.allowsSelection = false
       
    }
    
    //MARK: - Bar Button Item
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        //this changes the mode
        if coordinateMode {
            sender.image =  UIImage(systemName: "pencil.circle")
            searchBar.isUserInteractionEnabled = true
            //change input etc. //now it is in address mode
        } else {
            sender.image =  UIImage(systemName: "globe")
            //now it is coordinate mode, input is lat and longitiude
        }
        
        coordinateMode = !coordinateMode

    }
    
    //SearchBar
    
   
    
}

//MARK: - Search Bar Methods
extension NearbyGymsViewController: UISearchBarDelegate {
    //let coordinates = ""
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if coordinateMode {
            showAlert()
            return false
        } else {
            return true
        }
        
    }
    
    
    func showAlert() {
        
        var latitudeTextField = UITextField()
        var longitudeTextField = UITextField()
        
        let alert = UIAlertController(title: "Find nearby gyms to a specfic location", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Search Gyms", style: .default) { (action) in
            //what will happen when you press action button
            //dont force on wrap?
            self.searchBar.searchTextField.text = "\(latitudeTextField.text!); \(longitudeTextField.text!)"
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Latitude"
            latitudeTextField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Longitude"
            longitudeTextField = alertTextField
        }
        
        alert.addAction(action)
         
        present(alert, animated: true, completion: nil)
    }
        
//        searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//         let alert = UIAlertController(title: "jjj", message: "",u preferredStyle: .alert)
//               let action = UIAlertAction(title: "Search Gyms", style: .default) { (action) in
//                  //what will happen when you press add item
//                   print("Print Success")
//              }
//
//              alert.addAction(action)
//
//               present(alert, animated: true, completion: nil)
//
        
        //put the inputs into the search box
       // searchBarSearchButtonClicked(searchBar)
        
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
       
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



