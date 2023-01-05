//
//  OnboardingCollectionViewCell.swift
//  Rig
//
//  Created by Muhammad Mudassar Yasin on 19/10/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var img: UIImageView!
    static let identifier = "OnboardingCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
