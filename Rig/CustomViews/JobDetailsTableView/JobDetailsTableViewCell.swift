//
//  JobDetailsTableViewCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 04/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class JobDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
