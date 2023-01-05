//
//  SocialiseVC.swift
//  Rig
//
//  Created by Ale on 9/21/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import SideMenu
class SocialiseVC: UIViewController, UIDocumentInteractionControllerDelegate {


    

    @IBOutlet var socialiseCollectionView: UICollectionView!
    @IBOutlet weak var userImageView: UIImageView!
    var socializerViewModel = SocializerViewModel()
    var centerFlowLayout: SJCenterFlowLayout {
        return socialiseCollectionView.collectionViewLayout as! SJCenterFlowLayout
    }
    var scrollToEdgeEnabled: Bool = true
    var profileViewModel = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        socialiseCollectionView.delegate =  self
        socialiseCollectionView.dataSource =  self
        SharedModel.sharedInstance.setStatusBarColor()
        registerXib()
         

        //getAllUser()
        getSocializerAPI()
        // Do any additional setup after loading the view.
        
        centerFlowLayout.itemSize = CGSize(
            width: view.bounds.width * 0.8,
            height:  view.bounds.height * 0.7
        )
        
        centerFlowLayout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.6, sideItemAlpha: 0.6, sideItemShift: 0.0)
        centerFlowLayout.scrollDirection = .horizontal
    }

    // MARK: - Custom Methods

    func registerXib() {
        socialiseCollectionView.register(UINib(nibName: "SwipeFriendCell", bundle: nil), forCellWithReuseIdentifier: "SwipeFriendCell")
    }

    func getSocializerAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            var params  = SocializerParams()
            params.offset = 0
            socializerViewModel.getSocializers(SocializersParams: params) { (Socializer) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if Socializer?.status == APIStatus.Success.rawValue
                {
                    self.socializerViewModel.socializeData = (Socializer?.data)!
                    self.socialiseCollectionView.reloadData()
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG,message:Socializer?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                print (message ?? "")

                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }

        }
    }



    // MARK: - IBActions

    @IBAction func btnActionSeeAll(_ sender: UIButton) {
        print("Nothing")
    }
    @IBAction func menubuttonTapped(_ sender: UIButton) {
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
}

// MARK: - Extension for collectionview

extension SocialiseVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  return self.allUserData?.users?.count ?? 0
        return socializerViewModel.socializeData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeFriendCell", for: indexPath) as! SwipeFriendCell
        let model = SwipeFriendCellViewModel(socialize: socializerViewModel.socializeData[indexPath.row], viewController: self)
        cell.SwipeFriendCellViewModel = model
        
        let premium = UserDefaults.standard.bool(forKey: "isPremium")
        if premium == true {
            cell.premiumImage.isHidden = false
        } else {
            cell.premiumImage.isHidden = true
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Pid = socializerViewModel.socializeData[indexPath.row].id
        RIG.NavigationManager.navigateToPublicProfileViewController(Pid: Pid ?? 0, viewController: self)
        if self.scrollToEdgeEnabled, let cIndexPath = centerFlowLayout.currentCenteredIndexPath,
            cIndexPath != indexPath {
            centerFlowLayout.scrollToPage(atIndex: indexPath.row)

        }
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = collectionView.bounds.height
//        return CGSize(width: collectionView.frame.width - 100, height: height - 50)
//        // return CGSize(width: view.bounds.width - 50, height: view.bounds.height / 1.5)
//    }
    
     
}
