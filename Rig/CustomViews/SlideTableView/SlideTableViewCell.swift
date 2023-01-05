//
//  SlideTableViewCell.swift
//  Hitchman
//
//  Created by STC on 11/19/18.
//  Copyright © 2018 STC. All rights reserved.
//

import UIKit

class SlideTableViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var viewDark: UIView!
    
    @IBOutlet var rightArrowImg: UIImageView!
    @IBOutlet var imageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.imageIcon.image = self.imageIcon.image!.withRenderingMode(.alwaysTemplate)
//        self.imageIcon.tintColor = UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
