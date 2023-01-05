//
//  MyNetworkCell.swift
//  Rig
//
//  Created by Muhammad Mudassar Yasin on 01/07/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import iOSDropDown
import Toast_Swift

protocol MyNetworkCellDelegate : AnyObject {
    func didPressButton(_ tag: Int)
}

class MyNetworkCell: UITableViewCell {
    
    var cellDelegate: MyNetworkCellDelegate?
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnOptions: UIButton!
   // var cellDelegate: YourCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUser.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func btnPopUpAction(_ sender: UIButton) {
//        RIG.NavigationManager.cellPopUpshow(in: self, notificationDelegate: self)
        let view = MyNetworkPopUp()
        
        self.showToast(view, duration: .infinity, position: .center, completion: {didTap in
            self.hideToast()
        })
       // self.hideToast() = self.showToast(view)
      //  cellDelegate?.didPressButton(sender.tag)
    }
}
