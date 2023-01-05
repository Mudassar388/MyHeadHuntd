//
//  NewsFeedCell.swift
//  Rig
//
//  Created by Ale on 12/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    //MARK:- Variables
    var commentDelegate: CommentOnPost?
    
    //MARK:- IBOutlets
    @IBOutlet weak var feedIV: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileIV: UIButton!
    @IBOutlet weak var postDescriptionLbl: UILabel!
    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var btnPostComment: UIButton!
    @IBOutlet weak var btnShowComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnRate: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- IBActions
    
    @IBAction func btnActionShowComment(_ sender: UIButton) {
        commentDelegate?.showComment(tag: sender.tag)
    }
    
    @IBAction func btnActionSendComment(_ sender: UIButton) {
        commentDelegate?.sendComment(tag: sender.tag)
    }
    
    @IBAction func btnActionSharePost(_ sender: UIButton) {
        commentDelegate?.sharePost(tag: sender.tag)
    }
    
    @IBAction func btnActionRatePost(_ sender: UIButton) {
        commentDelegate?.ratePost(tag: sender.tag)
    }
}

//MARK:- Protocol
protocol CommentOnPost: class {
    func showComment(tag: Int)
    func sendComment(tag: Int)
    func sharePost(tag: Int)
    func ratePost(tag: Int)
}
