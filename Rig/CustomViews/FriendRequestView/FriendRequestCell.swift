//
//  FriendRequestCell.swift
//  Rig
//
//  Created by Ale on 12/6/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class FriendRequestCell: UITableViewCell {

    var requestResponseDelegate: RequestReponseProtocol?
    
    @IBOutlet weak var friendProfileIV: UIImageView!
    @IBOutlet weak var friendNameLbl: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var btnAcceptReq: UIButton!
    
    @IBOutlet weak var btnRejectRequest: UIButton!
    
    
   // @IBOutlet weak var btnAcceptRequest: UIButton!
   // @IBOutlet weak var btnRejectRequest: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        btnRejectRequest.borderWidth = 2
//        btnRejectRequest.borderColor = .green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionAccept(_ sender: UIButton) {
        requestResponseDelegate?.accept(tag: sender.tag)
    }
    
    @IBAction func btnActionReject(_ sender: UIButton) {
        requestResponseDelegate?.reject(tag: sender.tag)
    }
}

protocol RequestReponseProtocol: class {
    func accept(tag: Int)
    func reject(tag: Int)
}
