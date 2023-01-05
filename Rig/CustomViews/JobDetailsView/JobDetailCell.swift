//
//  JobDetailCell.swift
//  Rig
//
//  Created by Ale on 12/6/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class JobDetailCell: UITableViewCell {

    var applyJobProtocol: ApplyJobProtocol?
    
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblJobDescription: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var btnApplyJob: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func btnActionApplyJob(_ sender: UIButton) {
        applyJobProtocol?.applyForJob(tag: sender.tag)
    }
    
}

protocol ApplyJobProtocol: class {
    func applyForJob(tag: Int)
}
