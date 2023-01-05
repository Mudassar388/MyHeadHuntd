//
//  VacanciesCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 23/03/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class VacanciesCell: UITableViewCell {

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var vacancyIV: UIImageView!
    @IBOutlet weak var jobLocationLabel: UILabel!
    
    @IBOutlet weak var experienceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
