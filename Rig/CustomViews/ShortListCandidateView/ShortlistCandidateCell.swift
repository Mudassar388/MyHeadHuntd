//
//  ShortlistCandidateCell.swift
//  Rig
//
//  Created by Ale on 9/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class ShortlistCandidateCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var profileIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
