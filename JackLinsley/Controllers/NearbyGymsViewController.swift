//
//  NearbyGymsViewController.swift
//  JackLinsley
//
//  Created by My Apps on 31/12/2020.
//

import UIKit

class NearbyGymsViewController : UITableViewController {
    //need a strings class
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
         //let nearestGym = gymArray[0].name
          
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



