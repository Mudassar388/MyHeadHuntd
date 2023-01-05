//
//  SwipeSocializerCollectionViewCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 03/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class SwipeSocializerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var removeBtn: UIButton!
    var SwipeFriendCellViewModel : SwipeFriendCellViewModel!
    {
        didSet
        {
            self.populateData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.shadowColor = UIColor.black.cgColor
        //bgView.layer.shadowOffset = CGSize(width:0.0, height:4.0);
        bgView.layer.shadowOpacity = 0.3;
        bgView.layer.shadowOffset = CGSize.zero
        bgView.layer.shadowRadius = 10
        bgView.layer.masksToBounds = false;
        
        requestBtn.clipsToBounds = true
        requestBtn.layer.cornerRadius = 10
        requestBtn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    @IBAction func btnRemoveAction(_ sender: Any) {
        sendFriendRequestAPI(profileID: SwipeFriendCellViewModel.socialize?.id)
    }
    
    @IBAction func sendRequestAction(_ sender: Any) {
  //      sendFriendRequestAPI(profileID:  SwipeFriendCellViewModel.socialize?.id)
    }
    func populateData()
    {
        fullNameLabel.text = "\(SwipeFriendCellViewModel.socialize?.firstName ?? "") \(SwipeFriendCellViewModel.socialize?.lastName ?? "")"
        designationLabel.text = "\(SwipeFriendCellViewModel.socialize?.designation?.title ?? "")"
        userPhoto.loadSimpleCloudImage(url:SwipeFriendCellViewModel.socialize?.profileImage)


    }
    func sendFriendRequestAPI(profileID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: SwipeFriendCellViewModel.viewController)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: SwipeFriendCellViewModel.viewController, withMessage: "")
            var params  = SentFriendRequestParams()
            params.requestTo = profileID
            SwipeFriendCellViewModel.profileViewModelCell.sendFriendRequestAPI(sentFriendRequestParams: params){ (responseData) in
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

 
