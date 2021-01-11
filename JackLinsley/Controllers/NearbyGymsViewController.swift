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
    var gyms: [GymModel] = []
    
    func didUpdateGyms(gyms: [GymModel]) {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! GymCell
        
        cell.selectionStyle = .none
//
//        // Linking cell in view to controller - create a new CELL subclass
//        let nameLabel = cell.viewWithTag(1000) as! UILabel
//        let openingHoursLabel = cell.viewWithTag(100) as! UILabel
//        let imagePosition1 = cell.viewWithTag(1) as! UIImageView
//        let imagePosition2 = cell.viewWithTag(2) as! UIImageView
//        let imagePosition3 = cell.viewWithTag(3) as! UIImageView
//        let imagePosition4 = cell.viewWithTag(4) as! UIImageView
//        let imagePosition5 = cell.viewWithTag(5) as! UIImageView
        
        //setting up cell
        cell.nameLabel.text = gyms[indexPath.row].name
        
       // nameLabel.text = gyms[indexPath.row].name
        
        let openingDescription = gyms[indexPath.row].openingDescription
        cell.openingHoursLabel.text = openingDescription
        cell.openingHoursLabel.textColor = openingDescription == "Open Now" ? UIColor.black : UIColor.red
        
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
        //clear table view?
        //replace tableview with current location date, to show this have a filled location
    }
}

////MARK: - Table View Methods
//extension NearbyGymsViewController: UITableView {
//}

//MARK: - Search Bar Methods
extension NearbyGymsViewController: UISearchBarDelegate {
    //Address Mode Input
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchBar.text //INPUT
        print(searchBar.text!)
        if let address = searchBar.text {
            //gymManager.fetchNearbyGyms(address)
            gymManager.performRequest()
        }
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
            
            if let lat = latitudeTextField.text, let long = longitudeTextField.text {
                //   self.gymManager.fetchNearbyGyms(lat, long)
                self.gymManager.performRequest()
                print(self.gyms)
                self.tableView.reloadData()
                
            }
            
            
            //            if latitudeTextField.text != "", longitudeTextField.text != "" {
            //                self.searchBar.searchTextField.text = "\(latitudeTextField.text!); \(longitudeTextField.text!)" //API INPUT
            //            } else {self.searchBar.shake()}
            
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


extension UITextField {
    
    
    //combine these
    
    //also dismiss keyboard by tapping else where
    //    func setupTextFields() {
    //           let toolbar = UIToolbar()
    //           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
    //                                           target: nil, action: nil)
    //           let doneButton = UIBarButtonItem(title: "Done", style: .done,
    //                                            target: self, action: #selector(doneButtonTapped))
    //
    //           toolbar.setItems([flexSpace, doneButton], animated: true)
    //           toolbar.sizeToFit()
    //
    //           textField1.inputAccessoryView = toolbar
    //           textField2.inputAccessoryView = toolbar
    //       }
    //
    //       @objc func doneButtonTapped() {
    //           view.endEditing(true)
    //       }
    
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
