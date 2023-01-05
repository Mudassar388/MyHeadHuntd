//
//  CompanyChatVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import JGProgressHUD
import SideMenu
class CompanyChatVC: UIViewController, UIDocumentInteractionControllerDelegate {
 
    //MARK:- Variables
    @IBOutlet weak var noChatFoundLbl: UILabel!
    
    var inboxArray: [GetInboxChat] = []
    
    
    var userName: String?
    var userId: Int?
    
    var ref: DatabaseReference?
//    private var reference: CollectionReference?
    var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var searchMsgTF: UITextField!
    var allFriends: AllFriends?
    
    //MARK:- IBOutlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var newMsgIcon: UIImageView!
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        contactsTableView.register(UINib.init(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        self.contactsTableView.reloadData()
        
//        searchMsgTF.attributedPlaceholder = NSAttributedString(string: "Search",
//                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(named: "serachText")])

        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(newMsgTapped(tapGestureRecognizer:)))
        

        
        newMsgIcon.isUserInteractionEnabled = true
        newMsgIcon.addGestureRecognizer(tapGestureRecognizer2)
        setLayout()
        getInboxChat() {
            if inboxArray.count == 0 {
                self.noChatFoundLbl.isHidden = false
            } else {
                self.noChatFoundLbl.isHidden = true
            }
        }
       // getFriendList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getFriendList()
    }
    
    //MARK:- Custom Methods
    
    
    func getInboxChat (completion: () -> ()) {
        MessageViewModel.shared.inboxChats { chats in
            self.inboxArray = chats
           
            self.contactsTableView.reloadData()
        }
        completion()
    }
    
    private func setLayout(){
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
    }
    
    private func getFriendList(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        
//        Repository.getAllFriends { (status, friends, message) in
//            hud.dismiss(animated: true)
//            if status{
//                self.allFriends = friends
//                self.contactsTableView.reloadData()
//            }else{
//                print("No Friends found")
//            }
//        }
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


    
    @objc func newMsgTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let vc = UIStoryboard(name: "Candidate", bundle: nil).instantiateViewController(identifier: "MessagesVC") as! MessagesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
  
//MARK:- Tableview delegate methods
extension CompanyChatVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.allFriends?.friends?.count ?? 0
        return inboxArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
//        cell.lblName.text = allFriends?.friends?[indexPath.row].friendFname ?? ""
        let users = inboxArray[indexPath.row].reciverdetail
        let messageArray = inboxArray[indexPath.row]
        
        // Date Conversion
        let iOsDate = messageArray.created_at ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: iOsDate)
        
        // Cell Data
        cell.lblName.text = users?.name
        userName = users?.name
        userId = users?.id
        cell.bottomMessage.text = messageArray.message
        cell.messageDate.text = String(dateFormatter.string(from: date ?? Date()))
        if let url = URL(string: users?.profile_image ?? "") {
            UIImage.loadFrom(url: url) { image in
                cell.userImage.image = image
            }
        }

        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = UIStoryboard(name: "Candidate", bundle: nil).instantiateViewController(identifier: "MessagesVC") as! MessagesVC
//        vc.friendID = self.allFriends?.friends?[indexPath.row].friend_ID ?? 0
//        vc.friendName = self.allFriends?.friends?[indexPath.row].friendFname ?? ""
        vc.userName = self.userName
        vc.userID = self.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 76.0
//    }
}


extension UIImage {

    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}
