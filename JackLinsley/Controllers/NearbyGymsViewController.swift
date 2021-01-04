//
//  NearbyGymsViewController.swift
//  JackLinsley
//
//  Created by My Apps on 31/12/2020.
//

import UIKit

class NearbyGymsViewController : UITableViewController {
    
    let gymArray = [
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true),
        Gym(name: "JD Gym", rating: 2, openingHours: true),
        Gym(name: "Spikes Gym", rating: 3, openingHours: true),
        Gym(name: "Pulse Fitness", rating: 5, openingHours: true)
    ]
    
    override func viewDidLoad() {
         //let nearestGym = gymArray[0].name
          
    }
    
    //Mark: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GymCell", for: indexPath)
        
        //create a new cell subclass
        let nameLabel = cell.viewWithTag(1000) as! UILabel //should it be a var
        let openingHoursLabel = cell.viewWithTag(100) as! UILabel
        let ratingPosition1 = cell.viewWithTag(1) as! UIImageView
        let ratingPosition2 = cell.viewWithTag(2) as! UIImageView
        let ratingPosition3 = cell.viewWithTag(3) as! UIImageView
        let ratingPosition4 = cell.viewWithTag(4) as! UIImageView
        let ratingPosition5 = cell.viewWithTag(5) as! UIImageView
        
        
        nameLabel.text = gymArray[indexPath.row].name
        
        if gymArray[indexPath.row].openingHours == true {
            openingHoursLabel.text = "Open Now"
        } else {
            openingHoursLabel.text = "Closed Now"
        }
        //how to refactor this
        switch gymArray[indexPath.row].rating {
        case 1:
            ratingPosition1.image = UIImage(named: "star_icon_filled")
            ratingPosition2.image = UIImage(named: "star_icon")
            ratingPosition3.image = UIImage(named: "star_icon")
            ratingPosition4.image = UIImage(named: "star_icon")
            ratingPosition5.image = UIImage(named: "star_icon")
        case 2:
            ratingPosition1.image = UIImage(named: "star_icon_filled")
            ratingPosition2.image = UIImage(named: "star_icon_filled")
            ratingPosition3.image = UIImage(named: "star_icon")
            ratingPosition4.image = UIImage(named: "star_icon")
            ratingPosition5.image = UIImage(named: "star_icon")
        case 3:
            ratingPosition1.image = UIImage(named: "star_icon_filled")
            ratingPosition2.image = UIImage(named: "star_icon_filled")
            ratingPosition3.image = UIImage(named: "star_icon_filled")
            ratingPosition4.image = UIImage(named: "star_icon")
            ratingPosition5.image = UIImage(named: "star_icon")
        case 4:
            ratingPosition1.image = UIImage(named: "star_icon_filled")
            ratingPosition2.image = UIImage(named: "star_icon_filled")
            ratingPosition3.image = UIImage(named: "star_icon_filled")
            ratingPosition4.image = UIImage(named: "star_icon_filled")
            ratingPosition4.image = UIImage(named: "star_icon")
        case 5:
            ratingPosition1.image = UIImage(named: "star_icon_filled")
            ratingPosition2.image = UIImage(named: "star_icon_filled")
            ratingPosition3.image = UIImage(named: "star_icon_filled")
            ratingPosition4.image = UIImage(named: "star_icon_filled")
            ratingPosition5.image = UIImage(named: "star_icon_filled")
        
        default: //can i get rid as i wont need this if the rating is always 1-5
            ratingPosition1.image = UIImage(named: "star_icon")
            ratingPosition2.image = UIImage(named: "star_icon")
            ratingPosition3.image = UIImage(named: "star_icon")
            ratingPosition4.image = UIImage(named: "star_icon")
            ratingPosition5.image = UIImage(named: "star_icon")
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
      //Mark: - Tableview Delegate Methods
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       tableView.allowsSelection = false
       
    }

}




