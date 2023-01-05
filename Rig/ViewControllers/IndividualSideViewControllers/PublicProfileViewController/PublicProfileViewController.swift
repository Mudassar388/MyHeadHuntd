//
//  PublicProfileViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 08.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class PublicProfileViewController: UIViewController{



    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var skillView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileIV: UIImageView!
    @IBOutlet weak var userCoverIV: UIImageView!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var abouLbl: UILabel!
    @IBOutlet weak var skillsCollectionView:UICollectionView!
    @IBOutlet weak var connectBtn:UIButton!
    @IBOutlet weak var messageBtn:UIButton!
    
    @IBOutlet weak var noSkillLbl: UILabel!
    var profileViewModel = ProfileViewModel()
    var skills : [JobSkill]?
    var profileId:Int?
   var datafor = SocializerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       // userProfileIV.image = UIImage(named: datafor.socializeData[0].profileImage ?? "") //datafor.socializeData[IndexPath].profileImage
//
        
        registerXib()
        // Do any additional setup after loading the view.
        updateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        getProfileData(profileID: profileId)
        self.abouLbl.text = "No About Data"
        

    }

    func registerXib() {
        skillsCollectionView.register(UINib(nibName: XIBViews.SkillsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBViews.SkillsCollectionViewCell)
    }

    // MARK: - Navigation
    func updateView() {
//        topView.addshadowColor()
        skillView.addshadowColor()
        aboutView.addshadowColor()
    }

    func updateData(){
        if let url = profileViewModel.profileV?.coverImage{
            userCoverIV.loadSimpleCloudImage(url: url)
        }
        if let url = profileViewModel.profileV?.profileImage{
            userProfileIV.loadSimpleCloudImage(url:url)
        }

        userNameLabel.text = (profileViewModel.profileV?.firstName ?? "")
        userDesignationLabel.text = profileViewModel.profileV?.designation?.title
        userLocation.text = profileViewModel.profileV?.country
        skills = profileViewModel.profileV?.skills
       
        

    }

    func UIButtonUpdate(){

        if profileViewModel.profileV?.isFriend ?? false {
           connectBtn.setTitle("Friend", for: .normal)
           connectBtn.isUserInteractionEnabled = false
         }else if profileViewModel.profileV?.isRequestSent ?? false{
            connectBtn.setTitle("Sent", for: .normal)
            connectBtn.isUserInteractionEnabled = false
        }
        if profileViewModel.profileV?.isPremium ?? true != true {
            messageBtn.setTitle("Message", for: .normal)
        }
    }

    func getProfileData(profileID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = ProfileVParams()
            params.profileID = profileID
            profileViewModel.getProfileVAPI(profileVParams: params){ (responseData) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if responseData?.status == APIStatus.Success.rawValue
                {
                    self.profileViewModel.profileV = responseData?.data
                    self.updateData()
                    self.UIButtonUpdate()
                   // self.abouLbl.text = self.profileViewModel.profileV?.about
                    if self.profileViewModel.profileV?.about == "" {
                        self.abouLbl.text = "No About Data"
                    } else {
                        self.abouLbl.text = self.profileViewModel.profileV?.about
                    }
                    if self.skills?.count == 0 {
                                self.noSkillLbl.isHidden = false
                            } else {
                                self.noSkillLbl.isHidden = true
                            }
                   
                    self.skillsCollectionView.reloadData()
                }else{
                    RIG.UIManager.showAlert(title:RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
        }
    }
    func sendFriendRequestAPI(profileID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = SentFriendRequestParams()
            params.requestTo = profileID
            profileViewModel.sendFriendRequestAPI(sentFriendRequestParams: params){ (responseData) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if responseData?.status == APIStatus.Success.rawValue
                {
                    self.profileViewModel.sentFriendRequest = responseData
                    self.connectBtn.setTitle("Sent", for: .normal)
                    self.connectBtn.isUserInteractionEnabled = false
                }else{
                    RIG.UIManager.showAlert(title:RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
        }
    }


    @IBAction func connectBtnTapped(_ sender: UIButton) {
        sendFriendRequestAPI(profileID: profileId)

    }
    @IBAction func messageBtnTapped(_ sender: UIButton) {


    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
}
extension PublicProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return skillsArray.count
        return   skills?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.SkillsCollectionViewCell, for: indexPath) as! SkillsCollectionViewCell
        cell.skillsLabel.text = skills?[indexPath.row].title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
}
