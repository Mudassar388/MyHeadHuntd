//
//  CommentCell.swift
//  Rig
//
//  Created by Ale on 11/23/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    //MARK:- IBOutelts
    
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var commentDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
