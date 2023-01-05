//
//  ChatTableViewCell.swift
//  Rig
//
//  Created by Mateen Nawaz on 18/06/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bottomMessage: UILabel!
    @IBOutlet weak var messageDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
