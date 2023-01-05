//
//  HomeVC.swift
//  Rig
//
//  Created by Ale on 12/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import JGProgressHUD
import SDWebImage
import Cosmos
import UIKit
import SideMenu
import iOSDropDown
import CoreMedia
class HomeVC: UIViewController,jobFeedDelegate ,CollectionTappedDelegate, UIDocumentInteractionControllerDelegate, ModalDelegate {
    //let vcaa = JobFilterVC()
    


    // MARK: - IBOutlets
    //MARK: - View controller delegate methods
    @IBOutlet weak var tfSort: DropDown!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var jobFeedsTableView: UITableView!
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var ProfilePopUpView: PopUpProfile!
    @IBOutlet weak var totalJobCount: UILabel!
    
    //MARK: - Refferal PopupView
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    
    // MARK: - Varibales
    var homeViewModel = HomeViewModel()
    var socializerViewModel = SocializerViewModel()
    var filterbysort  = JobFeedParams()
    override func viewDidLoad() {
        super.viewDidLoad()
//        filterBtn.isHidden = true
        registerXIB()
        updateSortView()
        getJobFeedsAPI(filterbysort)
        SharedModel.sharedInstance.setStatusBarColor()
        print( " \(RIG.DataManager.userRIG)........" +
               "................................................")
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification), name: Notification.Name("FilterNotificationIdentifier"), object: nil)
        //        totalJobCount.text = "\(homeViewModel.jobFeedModel?.data?.total ?? 0)"
        
        blurView.bounds = self.view.bounds
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
    
    }

    override func viewWillAppear(_ animated: Bool) {
        self.filterbysort.sortOrder = 0
        self.filterbysort.lastID = 0
//        sort.id = 0
            //getJobFeedsAPI()
        
            //getSocializerAPI()

    }
    override func viewDidAppear(_ animated: Bool) {
//        popupAction(desireView: popUpView)
//        popupAction(desireView: blurView)
        
    }
    
    
    func popupAction(desireView: UIView) {
        let backgroundView = self.view!
        backgroundView.addSubview(desireView)
        
        desireView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desireView.alpha = 0
        desireView.center = backgroundView.center
        
        UIView.animate(withDuration: 0.3, animations: {
            desireView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desireView.alpha = 1
        })
    }



    // MARK: - Custom Methods
    func registerXIB() {
         jobFeedsTableView.register(UINib(nibName: XIBViews.JobFeedsTableViewCell, bundle: nil), forCellReuseIdentifier: XIBViews.JobFeedsTableViewCell)
        // jobFeedsTableView.register(UINib(nibName: "JobFeedsSocializerCell", bundle: nil), forCellReuseIdentifier: "JobFeedsSocializerCell")
    }


    func setLayout(){

    }

//    func setUserImage(from url: String) {
//        guard let imageURL = URL(string: url) else { return }
//            guard let imageData = try? Data(contentsOf: imageURL) else { return }
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.userImageView.image = image
//            }
//
//    }

//
    
    @IBAction func submitBtnAction(_ sender: Any) {
    }
    
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    

    @IBAction func filterButtonTapped(_ sender:UIButton) {
        let jobFilterVC = self.storyboard?.instantiateViewController(withIdentifier: "JobFilterVC") as! JobFilterVC
        //jobFilterVC.modalPresentationStyle = .fullScreen
        jobFilterVC.delegate = self
        self.tabBarController?.present(jobFilterVC, animated: true)
    }
    func changeValue(value: String) {

    }
    @IBAction func btnSortAction(_ sender: Any) {
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
       // case 4: break
        case 5:
            RIG.NavigationManager.navigateToAboutUSViewController(pagetitle: PageTitle.AboutUS.rawValue,viewController: self)
        case 6: break
        case 7: break
        case 8: break

        default: break

        }






    }
    //MARK: - Delegate Methods
    func applyForJobTapped(jobID:Int?){
        RIG.NavigationManager.navigateToJobDetailsViewController(jobID: jobID ?? 0, viewController: self)
    }
    //MARK: - Collectionview Delegate Methods
    func tabOnSocializer(profileid: Int?) {
        RIG.NavigationManager.navigateToPublicProfileViewController(Pid: profileid ?? 0, viewController: self)
    }


    //MARK: - API CALLING
    func getJobFeedsAPI(_ params: JobFeedParams){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
           // var params  = JobFeedParams()
//            params.lastID = 0
//            params.sortOrder = sort.id
//            params.location = sort.location
//            params.jobType = sort.jobType
//            params.careerLevel = sort.careerLevel
            homeViewModel.getJobFeeds(jobFeedParams: params) { (jobsfeeds) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if jobsfeeds?.status == APIStatus.Success.rawValue
                {
                    self.homeViewModel.jobFeeds = (jobsfeeds?.data?.jobs)!
                    self.jobFeedsTableView.reloadData()
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:jobsfeeds?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                print (message ?? "")

                RIG.UIManager.showAlert(title:RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }


        }
    }
    func updateSortView() {
        tfSort.optionArray = ["Newest", "Oldest", "A to Z", "Z to A"]
        
            
        tfSort.isSearchEnable = false
        tfSort.selectedRowColor = .lightGray
        tfSort.checkMarkEnabled = false
        tfSort.arrowColor = .gray
        tfSort.arrowSize = 6
        tfSort.text = "Newest"
        tfSort.layer.cornerRadius = 5
        tfSort.layer.borderWidth = 1
        tfSort.layer.borderColor = UIColor.lightGray.cgColor
        
        tfSort.didSelect{(_ , index ,_) in
            self.tfSort.selectedIndex = index
            self.filterbysort.sortOrder = index
            
            self.getJobFeedsAPI(self.filterbysort)
            
    }
 
//    func getSocializerAPI(){
//        if RIG.NetworkManager.isNetworkReachable(viewController: self)
//        {
//            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
//            var params  = SocializerParams()
//            params.offset = 0
//            socializerViewModel.getSocializers(SocializersParams: params) { (Socializer) in
//                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
//                if Socializer?.status == APIStatus.Success.rawValue
//                {
//                    self.socializerViewModel.socializeData = (Socializer?.data)!
//                    self.jobFeedsTableView.reloadData()
//                }else{
//                   RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:Socializer?.message, okButton: true, viewController: self) { _ in }
//                }
//            } errorMessage: { message in
//                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
//                print (message ?? "")
//
//             RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
//            }
//
//        }
//    }

}
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    

    @objc func methodOfReceivedNotification(_ notification: NSNotification) {
        var filterObjArr = NSArray()
        if let dict = notification.userInfo as? [String: Any],
           let filterObj = dict["obj"] as? JobFeedParams
        {
            
            getJobFeedsAPI(filterObj)
        }
        
        
        print("i am here")
        DispatchQueue.main.async {
            self.jobFeedsTableView.reloadData()
        }
    }
    
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return homeViewModel.jobFeeds.count
            }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let row = indexPath.row
//        if row == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "JobFeedsSocializerCell") as! JobFeedsSocializerCell
//            let model = JobFeedsSocializerCellViewModel(socializers:socializerViewModel.socializeData, viewController: self)
//            cell.JobFeedsSocializerCellViewModel = model
//            cell.delegate = self
//            return cell
//        }else{
//            var index = indexPath.row
//            if indexPath.row == homeViewModel.jobFeeds.count{
//                index -= 1
//            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobFeedsTableViewCell") as! JobFeedsTableViewCell
            let model = JobFeedsTableViewCellModel.init(jobFeeds: homeViewModel.jobFeeds[indexPath.row], viewController: self )
            cell.JobFeedsTableViewCellModel = model
        self.totalJobCount.text = "\(homeViewModel.jobFeedModel?.data?.total ?? 0)"
            cell.delegate = self
        return cell


    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let JobID =  homeViewModel.jobFeeds[indexPath.row].id {
            RIG.NavigationManager.navigateToJobDetailsViewController(jobID:JobID, viewController: self)
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let height: CGFloat = 110
//        if (indexPath.row == 2) {
//                    height = 192
//        }
        return height
    }



}
