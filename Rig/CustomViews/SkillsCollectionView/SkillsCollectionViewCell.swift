//
//  SkillsCollectionViewCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 04/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class SkillsCollectionViewCell: UICollectionViewCell {
    
    var completion: (() -> ())?
    static let identifier = "SkillsCollectionViewCell"
    
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.height/2
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        //        isBtnPressed = true
        completion?()
    }
}
