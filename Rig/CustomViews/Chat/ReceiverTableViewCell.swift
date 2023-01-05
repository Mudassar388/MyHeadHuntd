//
//  ReceiverTableViewCell.swift
//  Rig
//
//  Created by Mateen Nawaz on 19/06/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var receiverMessageTextView: UITextView!
    @IBOutlet weak var sentTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
