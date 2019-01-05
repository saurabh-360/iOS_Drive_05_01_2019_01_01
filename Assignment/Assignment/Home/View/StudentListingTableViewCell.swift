//
//  StudentListingTableViewCell.swift
//  Assignment
//
//  Created by Saurabh Yadav on 05/01/19.
//  Copyright © 2019 Viacom 18. All rights reserved.
//

import UIKit

class StudentListingTableViewCell: UITableViewCell {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model : StudentListingModel) {
        self.ageLabel.text = "\(model.age!)"
        self.genderLabel.text = "\(model.gender!)"
        self.nameLable.text = "\(model.name!)"
    }

}
