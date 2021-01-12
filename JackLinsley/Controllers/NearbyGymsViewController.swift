//
//  NearbyGymsViewController.swift
//  JackLinsley
//
//  Created by My Apps on 31/12/2020.
//

import UIKit
//need a strings class //use tableview in a view as an improvement?? //when serperating out into extensions, should IBOutlets and in viewDidLoad be in there too?
//mention ho not got dark mode enabled
class NearbyGymsViewController : UITableViewController, GymManagerDelegate {
    
    //how to name this boolean
    var coordinateModeEnabled = true
    var gymManager = GymManager()
    var gyms: [PlaceModel] = []
    
    func didUpdateGyms(gyms: [PlaceModel]) {
        DispatchQueue.main.async {
            self.gyms = gyms
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        searchBar.delegate = self
        gymManager.delegate = self
        modeSelection(coordinateModeEnabled: coordinateModeEnabled)
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    func modeSelection(coordinateModeEnabled: Bool) {
        if coordinateModeEnabled {
            barButton.image =  UIImage(systemName:K.images.coordinateInput)
            searchBar.placeholder = K.coordinateSearchPlaceholder
        } else {
            //addressModeEnabled:
            barButton.image =  UIImage(systemName: K.images.addressInput)
            searchBar.placeholder = K.addressSearchPlaceholder
        }
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! GymCell
        
        cell.selectionStyle = .none
        
        cell.nameLabel.text = gyms[indexPath.row].name

        let openingDescription = gyms[indexPath.row].openingDescription
        cell.openingHoursLabel.text = openingDescription
        cell.openingHoursLabel.textColor = openingDescription == K.openNow ? UIColor.black : UIColor.red
        
        if let ratingDouble = gyms[indexPath.row].rating {
            let rating = Int(ratingDouble)
            
            let ratingPositions = [cell.ratingPosition1, cell.ratingPosition2, cell.ratingPosition3, cell.ratingPosition4, cell.ratingPosition5]
            
            for (index, position) in ratingPositions.enumerated() {
                position!.image = index < rating ? UIImage(named: K.images.filledStar) : UIImage(named: K.images.emptyStar)
            }
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
        //clear table view? //leave there like google
        //replace tableview with current location date, to show this have a filled location
    }
}

////MARK: - Table View Methods
//extension NearbyGymsViewController: UITableView {
//}

//MARK: - Search Bar Methods
extension NearbyGymsViewController: UISearchBarDelegate {
    
    //Search Bar depending on mode selected
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if coordinateModeEnabled {
            coordinateEntry()
            return false
        } else {
            barButton.isEnabled = false
            searchBar.searchTextField.addAccessory(numberpad: false)
            return true
        }
    }
    
    //Address Mode Input
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "", let address = searchBar.text {
            gymManager.fetchGyms(using: address, withinDistanceOf: K.nearbyDistance)
           searchBar.endEditing(true)
        } else {
            searchBar.shake()
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" || searchBar.resignFirstResponder() {
            barButton.isEnabled = true
            return true
        } else {return false}
    }
    
    //Coordinate Mode Input
    func coordinateEntry() {
        var latitudeTextField = UITextField()
        var longitudeTextField = UITextField()
        
        let alert = UIAlertController(title: K.alertTitle, message: K.alertMessage, preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.latitudeTextfieldPlaceholder
            alertTextField.keyboardType = .numberPad
            alertTextField.addAccessory(numberpad: true)
            latitudeTextField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.longitudeTextfieldPlaceholder
            alertTextField.keyboardType = .numberPad
            alertTextField.addAccessory(numberpad: true)
            longitudeTextField = alertTextField
            
        }
        
        let action = UIAlertAction(title: K.searchButton, style: .default) { (action) in
            
            if let latitude = latitudeTextField.text, let longitude = longitudeTextField.text {
                if latitude != "" && longitude != "" {
                    self.gymManager.fetchGyms(using: latitude, longitude, withDistanceOf: K.nearbyDistance)
                    self.searchBar.text = "\(latitude), \(longitude)"
                    print(self.gyms)
                    self.tableView.reloadData()
                } else {
                    self.searchBar.shake()
                }
            }
        }
        
        let cancel = UIAlertAction(title: K.cancelButton, style: .default) { (action) in } //Just dismisses alert
        
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
