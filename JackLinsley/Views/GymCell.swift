 //
//  GymCell.swift
//  JackLinsley
//
//  Created by My Apps on 11/01/2021.
//

import UIKit

class GymCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! //naming check, also check constriaints and colours and refactoring
        
        @IBOutlet weak var openingHoursLabel: UILabel!
        
        @IBOutlet weak var ratingPosition1: UIImageView! //make this a class
        @IBOutlet weak var ratingPosition2: UIImageView!
        @IBOutlet weak var ratingPosition3: UIImageView!
        @IBOutlet weak var ratingPosition4: UIImageView!
        @IBOutlet weak var ratingPosition5: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
 
 
