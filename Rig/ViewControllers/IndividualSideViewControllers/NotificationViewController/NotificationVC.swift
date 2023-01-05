//
//  NotificationVC.swift
//  Rig
//
//  Created by Ale on 12/6/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import SideMenu
import MapKit
class NotificationVC: UIViewController, UIDocumentInteractionControllerDelegate {

    //MARK:- Variables
    var allNotifications: Welcome?
    var mynot: Datum?
    var notiData = ["sikandar wants to join you","ali raza accepted your request","Azam request is pending"]
    //MARK:- IBOutlets
    @IBOutlet weak var friendRequestTableView: UITableView!
    
    @IBOutlet weak var noNotificationLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        registerXib()
//        NotificationViewModel.shared.sendFriendRequest { notify in
//            print(notify.data)
//        }
        notificationApi()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllNotification()
        if allNotifications?.data?.count ?? 0 == 0 {
            self.noNotificationLabel.isHidden = false
        } else {
            self.noNotificationLabel.isHidden = true
        }
    }
    //MARK:- Custom Methods
    
    private func registerXib(){
        friendRequestTableView.register(UINib(nibName: "FriendRequestCell", bundle: nil), forCellReuseIdentifier: "FriendRequestCell")
    }
    
    
    func notificationApi() {
        //let designation = "designation"
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
        HTTPManager.shared.get("received/friend-requests") { (response: Welcome?) in
            hud.dismiss()
            guard let respo = response else {return}
            if respo.status == 200 {
                
                self.allNotifications?.data = respo.data ?? []
                self.friendRequestTableView.reloadData()
                //print(allNotifications, "this our skill")
            } else {
                print(respo.status)
            }
        }
    }
    
    
    
    
    private func getAllNotification(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
        Repository.getNotificationRequest { (status, data, message) in
            hud.dismiss()
            if status {
                self.allNotifications = data
//                if(self.allNotifications?.data?.request?.count == 0){
//                    self.noNotificationLabel.isHidden = false
//                }
                self.friendRequestTableView.reloadData()
            }else{
                print("notifications failed ")
            }
        }
    }
    
    private func acceptRequest(friendId: String){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
        Repository.accpetRejectRequest(friendID: friendId, status: "1") { (status, data, message) in
            hud.dismiss()
            if status{
                print("Friend Request accepted successfully")
            }else{
                print("unable to accept request")
            }
        }
    }

    private func rejectRequest(friendId: String){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
        Repository.accpetRejectRequest(friendID: friendId, status: "0") { (status, data, message) in
            hud.dismiss()
            if status{
                print("Friend Request rejected successfully")
            }else{
                print("unable to reject request")
            }
        }
    }
    @IBAction func imageBtnTapped(_ sender:UIButton) {
        let sideMenuVC = SideMenuVC()
        let menuLeftNavigationController = SideMenuNavigationController(rootViewController: sideMenuVC)
           // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
           // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
           // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController

        SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
        menuLeftNavigationController.menuWidth = view.frame.width * CGFloat(0.8)
        menuLeftNavigationController.presentationStyle.presentingEndAlpha = 0.4
        menuLeftNavigationController.statusBarEndAlpha = 0
        SideMenuManager.default.menuPresentMode = .viewSlideOutMenuIn
        //   SideMenuManager.default.menuBlurEffectStyle = .dark
           //SideMenuManager.default.menuAnimationFadeStrength = 0.6
        sideMenuVC.completionBlock = {(index) -> () in
               self.menuSelectionCompletion(index: index)
        }
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    func menuSelectionCompletion(index: Int) -> Void {
        //extra 3 buttton inthe botttom
        switch (index){
        case -5:
            // Viewp rofile image
            RIG.NavigationManager.navigateToViewProfilmageViewController(viewController: self)
        case -4:
            break
            // Edit profile image

        case -3:
            RIG.NavigationManager.logout()
        case -2:
            RIG.NavigationManager.navigateToAboutUSViewController(pagetitle: PageTitle.TermsAndConditions.rawValue,viewController: self)
        case -1:
            RIG.NavigationManager.navigateToAboutUSViewController(pagetitle: PageTitle.PrivacyPolicy.rawValue,viewController: self)
        case 0:
            RIG.NavigationManager.navigateToProfileViewController(viewController: self)
        case 1:
            RIG.NavigationManager.navigateToFavouriteJobsViewController(viewController: self)
        case 2:
            RIG.NavigationManager.navigateToMembershipPlanViewController(viewController: self)

        case 3: break
        case 4: break
        case 5:
            RIG.NavigationManager.navigateToAboutUSViewController(pagetitle: PageTitle.AboutUS.rawValue,viewController: self)
        case 6: break
        case 7: break
        case 8: break

        default: break

        }






    }
    
    //MARK:- IBActions
    
}

//MARK:- Tableview delegate methods
//RequestReponseProtocol
extension NotificationVC: UITableViewDelegate, UITableViewDataSource, RequestReponseProtocol {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifications?.data?.count ?? 0
        //return obj.count
        //return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestCell", for: indexPath) as! FriendRequestCell
       // let obj = allNotifications?.data[indexPath.row].request
        cell.friendNameLbl.text = allNotifications?.data?[indexPath.row].request?.firstName
        cell.friendProfileIV.sd_setImage(with: URL(string: "\(allNotifications?.data?[indexPath.row].request?.profileImage ?? "")"), placeholderImage: UIImage(named: "logo"))
        cell.requestResponseDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func accept(tag: Int) {
        acceptRequest(friendId: "\(self.allNotifications?.data?[tag].request?.id ?? 0)")
    }
    
    func reject(tag: Int) {
      rejectRequest(friendId: "\(self.allNotifications?.data?[tag].request?.id ?? 0)")
    }
    
    func setUserImage(from url: String) {
           guard let imageURL = URL(string: url) else { return }

               // just not to cause a deadlock in UI!
           DispatchQueue.global().async {
               guard let imageData = try? Data(contentsOf: imageURL) else { return }

               let image = UIImage(data: imageData)
               DispatchQueue.main.async {
                   self.userImageView.image = image
               }
           }
       }
}
