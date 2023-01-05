//
//  SwipeFriendCell.swift
//  Rig
//
//  Created by Ale on 9/21/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import SDWebImage
 

class SwipeFriendCell: UICollectionViewCell {


    //MARK:- IBOutlets
    @IBOutlet weak var friendProfileIV  : UIImageView!
    @IBOutlet weak var friendNameLbl    : UILabel!
    @IBOutlet weak var Desination       : UILabel!
    @IBOutlet weak var friendLocationLbl: UILabel!
    @IBOutlet weak var btnSendRequest   : UIButton!
    @IBOutlet weak var btnRemove        : UIButton!
    
    @IBOutlet weak var premiumImage: UIImageView!
    @IBOutlet weak var btnRequest       : UIButton!
    @IBOutlet weak var photoViewWidth   : NSLayoutConstraint!
    @IBOutlet weak var photoViewHeight  : NSLayoutConstraint!
    @IBOutlet weak var photoView        : UIView!
    //@IBOutlet weak var nameView: UIView!

    var SwipeFriendCellViewModel : SwipeFriendCellViewModel!
    {
        didSet
        {
            self.populateData()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // photoView.clipsToBounds = true
       // photoView.layer.cornerRadius = 10
       // photoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        btnRequest.clipsToBounds = true
        btnRequest.layer.cornerRadius = 10
        btnRequest.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        friendProfileIV.layer.borderWidth = 1.0
        friendProfileIV.layer.masksToBounds = false
        friendProfileIV.layer.borderColor = UIColor.white.cgColor
        friendProfileIV.layer.cornerRadius = friendProfileIV.frame.size.width/2
        friendProfileIV.clipsToBounds = true
        // Initialization code
        
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    @IBAction func btnActionSendRequest(_ sender: UIButton) {
        sendFriendRequestAPI(profileID: SwipeFriendCellViewModel.socialize?.id)
    }
    
    @IBAction func btnActionRemove(_ sender: UIButton) {
        //sendFriendRequestAPI(profileID: SwipeFriendCellViewModel.socialize?.id)
    }

    func populateData()
    {
        friendNameLbl.text = "\(SwipeFriendCellViewModel.socialize?.firstName ?? "") \(SwipeFriendCellViewModel.socialize?.lastName ?? "")"
        Desination.text = "\(SwipeFriendCellViewModel.socialize?.designation?.title ?? "")"
        friendProfileIV.loadSimpleCloudImage(url:SwipeFriendCellViewModel.socialize?.profileImage)


    }

    func sendFriendRequestAPI(profileID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: SwipeFriendCellViewModel.viewController)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: SwipeFriendCellViewModel.viewController, withMessage: "")
            var params  = SentFriendRequestParams()
            params.requestTo = profileID

            SwipeFriendCellViewModel.profileViewModelCell.sendFriendRequestAPI(sentFriendRequestParams:params){ (responseData) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.SwipeFriendCellViewModel.viewController)
                if responseData?.status == APIStatus.Success.rawValue
                {
                    self.SwipeFriendCellViewModel.profileViewModelCell.sentFriendRequest = responseData
                    RIG.UIManager.showAlert(title:RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self.SwipeFriendCellViewModel.viewController!) { _ in }
                }else{
                    RIG.UIManager.showAlert(title:RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self.SwipeFriendCellViewModel.viewController!) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.SwipeFriendCellViewModel.viewController)
                print (message ?? "")
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self.SwipeFriendCellViewModel.viewController!) { _ in }
            }
        }
    }
 }
