//
//  MealTableViewCell.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 10/01/2019.
//  Copyright © 2019 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
