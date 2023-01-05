//
//  CompanyHomeVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import Cosmos
import JGProgressHUD
import SideMenu
class CompanyHomeVC: UIViewController, UIDocumentInteractionControllerDelegate {
    //MARK:- Variables
    
    //MARK:- IBOutlets
    
    //MARK:- View Controller Life Cycle
    @IBOutlet var suggestionCollectionView: UICollectionView!
    var allUserData: AllUser?
    @IBOutlet weak var noJobLabel: UILabel!
    @IBOutlet weak var postJobBtn: UIButton!
    
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var btnSendRequest: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var buttonsView: UIView!
    var cellScale : CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        hideNavigationBar()

        self.suggestionCollectionView.isHidden = true
        self.swipeLabel.isHidden = true
        self.buttonsView.isHidden = true
        self.noJobLabel.isHidden = false
        self.postJobBtn.isHidden = false
       // getAllUser()
        
       // let screenSize = UIScreen.main.bounds.size
       // let cellWidth = floor(screenSize.width * cellScale)
       // let cellHeight = floor(screenSize.height * cellScale)
       // let insetX = (view.bounds.width - cellWidth) / 2.0
       // let insetY = (view.bounds.height - cellHeight) / 2.0
        
      //  let layout = self.suggestionCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
       // layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
       // self.suggestionCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SharedModel.sharedInstance.setStatusBarColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    @IBAction func postJobAction(_ sender: Any) {
        RIG.NavigationManager.navigateToPostJobViewController(viewController: self)
        print("SDCSDNSAMN, MSNDC.MSD,CVKSDM,NC KSD,CN.KJSD,MC S.KDJC SDKNC .SDKN<C .KSDNMC SKDNMC SDK")
    }
    
    func registerXib() {
        suggestionCollectionView.register(UINib(nibName: "SuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SuggestionCollectionViewCell")
    }
    
    func getAllUser(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
//        Repository.getAllUsers { (status, data, message) in
//            hud.dismiss()
//            if status{
//                self.allUserData = data
//                if((self.allUserData?.users!.count)! < 1){
//                    self.suggestionCollectionView.isHidden = true
//                    self.swipeLabel.isHidden = true
//                    self.buttonsView.isHidden = true
//                    self.noJobLabel.isHidden = false
//                    self.postJobBtn.isHidden = false
//                }
//                else{
//                    self.suggestionCollectionView.isHidden = false
//                    self.swipeLabel.isHidden = false
//                    self.buttonsView.isHidden = false
//                    self.noJobLabel.isHidden = true
//                    self.postJobBtn.isHidden = true
//                    self.suggestionCollectionView.reloadData()
//                }
//                
//            }else{
//                print("Could get all Users")
//            }
//        }
    }
    
    @IBAction func sideMenuAction(_ sender: Any) {
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
        case 0 :
            RIG.NavigationManager.navigateToCompanyProfileViewController(viewController: self)
        case 1 :
            RIG.NavigationManager.navigateToFavouriteJobsViewController(viewController: self)
        case 2 :
            RIG.NavigationManager.navigateToMembershipPlanViewController(viewController: self)
        case 3 : break
        case 4 : break
        case 5:
            RIG.NavigationManager.navigateToAboutUSViewController(pagetitle: PageTitle.AboutUS.rawValue,viewController: self)
        default: break

        }

    }







  
    //MARK:- Custom Methods
    
    fileprivate func setLayout(){
        
    }
    

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }

    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }

    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
//    func sendRequest(tag: Int) {
//           let hud = JGProgressHUD(style: .dark)
//           hud.textLabel.text = "Please wait..."
//           hud.show(in: self.view)
//           Repository.sendFriendRequest(friendId: "\(self.allUserData?.users?[tag].id ?? 0)") { (status, data, message) in
//               hud.dismiss()
//               if status{
//                   print("Friend request sent successfully \(message)")
//               }else{
//                   print("Unable to sent request \(message)")
//               }
//           }
//       }
    
    //MARK:- IBActions
    
}

extension CompanyHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  return self.allUserData?.users?.count ?? 0
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
        cell.friendNameLbl.text = (self.allUserData?.users?[indexPath.row].firstName ?? "") + " " + (self.allUserData?.users?[indexPath.row].lastName ?? "")
        cell.friendDesignationLbl.text = self.allUserData?.users?[indexPath.row].designation
        
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellWidth : CGFloat = 228.0
//
//        let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
//        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
//
//        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 228, height: 300)
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.suggestionCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludeSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
//        let roundedIndex = round(index)
//        
//        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
}
