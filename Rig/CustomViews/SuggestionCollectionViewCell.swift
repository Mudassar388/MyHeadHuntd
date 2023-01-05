//
//  SuggestionCollectionViewCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 04/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var friendProfileIV: UIImageView!
    @IBOutlet weak var friendNameLbl: UILabel!
    @IBOutlet weak var friendDesignationLbl: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var photoViewWidth: NSLayoutConstraint!
    @IBOutlet weak var photoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var nameView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        topView.layer.shadowOpacity = 0.25;
        topView.layer.masksToBounds = false;
        
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 10
        photoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        nameView.clipsToBounds = true
        nameView.layer.cornerRadius = 10
        nameView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        // Initialization code
    }
    
}

