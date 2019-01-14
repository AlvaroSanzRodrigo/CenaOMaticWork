//
//  ParticipantTableViewCell.swift
//  CenaOMatic
//
//  Created by Alvaro Sanz Rodrigo on 24/12/2018.
//  Copyright © 2018 Alvaro Sanz Rodrigo. All rights reserved.
//

import UIKit

class ParticipantTableViewCell: UITableViewCell {

    @IBOutlet weak var participantName: UILabel!
    @IBOutlet weak var isPayed: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
