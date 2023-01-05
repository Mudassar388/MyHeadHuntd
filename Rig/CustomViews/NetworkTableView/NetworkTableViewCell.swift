//
//  NetworkTableViewCell.swift
//  Rig
//
//  Created by Sajjad Malik on 13.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class NetworkTableViewCell: UITableViewCell {

    static let identifire = "NetworkTableViewCell"
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lblConnectedTime: UILabel!
    @IBOutlet weak var lblDesgination: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
