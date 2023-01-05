//
//  ProfileVC.swift
//  Rig
//
//  Created by STC Macbook Pro on 23/03/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
import CoreMIDI
import iOSDropDown

class ProfileVC: UIViewController, jobFeedDelegate {
    
    @IBOutlet weak var userDesignationLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileIV: UIImageView!
    @IBOutlet weak var userCoverIV: UIImageView!
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var noJobLbl: UILabel!
    @IBOutlet weak var appliedCountLabel: UILabel!
    @IBOutlet weak var lblAddSkills: UILabel!
    @IBOutlet weak var shortListedCountLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var aboutTextField: UITextView!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var addSkillTV: DropDown!
    
    @IBOutlet weak var addSkillView: UIView!
    @IBOutlet weak var skillsViewHight: NSLayoutConstraint!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var cvViewsCountLabel: UILabel!
    
    @IBOutlet weak var mySkillsView: UIView!
    @IBOutlet weak var mySkillsLabel: UILabel!
    @IBOutlet weak var addSkillsBgView: UIView!
    @IBOutlet weak var addSkillViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lbljobUnder: UILabel!
    @IBOutlet weak var lblaboutUnder: UILabel!
    @IBOutlet weak var lblAppliedJob: UILabel!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var aboutJobView: UIView!
    @IBOutlet weak var appliedJobTableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var crownImg: UIImageView!
    @IBOutlet weak var premiumHeight: NSLayoutConstraint!
    
    @IBOutlet weak var goldenMemberLbl: UILabel!
    @IBOutlet weak var premiumImg: UIImageView!
    
    
    
    var profileViewModel = ProfileViewModel()
    var xPos : CGFloat = 8
    var yPos : CGFloat = 20
    var skills : [JobSkill] = []
    var skillsArray = [String]()
    let imagePicker = UIImagePickerController()
    var getcoverPhoto: String?
    var registrationViewModel = RegistrationViewModel()
    var skillArray: [String] = []
    var skillIntArray = [Int]()
    var indexForCell = 0
    var viewmodel = DesignationData()
    var button = buttonpress.profile
    enum buttonpress: String {
        case profile
        case cover
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        premiumMembers()
        
        self.viewmodel.editProfileDrop() {[weak self] in
            self?.updateDropdown()
        }
    
        appliedCountLabel.text = "0"
        shortListedCountLabel.text = "0"
        cvViewsCountLabel.text = "0"
        aboutTextField.text = "Elite Apps is a company providing professional-level apps (Android, iOS) design and development solution, Brand designs, Software development, etc. We design, manage, build and maintain high quality solutions for a wide range of businesses and individuals. We are an app development company with an aim of helping our customers to take full advantage of internet technology. We understand the limitation of budget for a developing business hence we endeavored and succeeded in bringing down the cost of developing an app and other services to much lower rates as compared to the market. Our low cost of web development gives us an edge over other such companies."
        collectionView.reloadData()
        let layout = CenterAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 30)
        self.collectionView.collectionViewLayout = layout
        skillsViewHight.constant = 100
        hideSkillsView()
        registerXIB()
        updateView()
        SharedModel.sharedInstance.setStatusBarColor()
        imagePicker.delegate = self
      //  getAppliedJobs(lastID: 50, limit: 20)
        getAppliedJob()
        
        if RIG.DataManager.isUserLoggedIn ?? false {
            let pkiImage = UserDefaults.standard.string(forKey: "cover")
            userCoverIV.loadSimpleCloudImage(url: pkiImage)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfileData(profileID:RIG.DataManager.userRIG?.id)
        about()
       
//        if profileViewModel.appliedJob.count >= 0 {
//            self.noJobLbl.isHidden = false
//            print("there is no applied job")
//        } else
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        vc.profile = profileViewModel
        self.navigationController?.pushViewController(vc, animated: true)
       // NotificationCenter.default.post(name: NSNotification.Name("editprofilenotification"), object: nil, userInfo: ["object": profileViewModel])
        
        
        
    }
    
    @IBAction func btnProfileEditAction(_ sender: Any) {
        self.button = .profile
        imagePickerSetup()
    }
    
    @IBAction func btnCoverEditAction(_ sender: Any) {
        self.button = .cover
        imagePickerSetup()
    }
    
    
    func updateView() {
        lblAddSkills.isHidden = true
        addSkillTV.isHidden = true
        doneBtn.isHidden = true
        addBtn.isHidden = true
        addSkillView.isHidden = true
        addSkillsBgView.isHidden = true
        lblaboutUnder.isHidden = true
        aboutView.isHidden = true
        statsView.isHidden = false
        statsView.addshadowColor()
        aboutView.addshadowColor()
        aboutView.addRadius(10)
        aboutJobView.addRadius(10)
        addSkillView.addshadowColor()
        aboutJobView.addshadowColor()
        addSkillsBgView.addshadowColor()
        skillsView.addshadowColor()
    }
    
    func registerXIB() {
        appliedJobTableView.delegate = self
        appliedJobTableView.dataSource = self
        appliedJobTableView.register(UINib(nibName: "JobFeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobFeedsTableViewCell")
    }
    
    func updateData(){
        skills.removeAll()
        skillsArray.removeAll()
        userNameLabel.text  = ((profileViewModel.profileV?.firstName) ?? "NO NAME") + " " + (profileViewModel.profileV?.lastName ?? "NO LAST NAME")
        userProfileIV.loadSimpleCloudImage(url:profileViewModel.profileV?.profileImage)
        userCoverIV.loadSimpleCloudImage(url:profileViewModel.profileV?.coverImage)
        userLocation.text = profileViewModel.profileV?.country
        userDesignationLabel.text = profileViewModel.profileV?.designation?.title
        if let  Skills = profileViewModel.profileV?.skills {
            skills = Skills
        }
        
        if skills.count > 0 {
            for i in 0...skills.count - 1  {
                skillsArray.append(skills[i].title ?? "")
            }
            collectionView.reloadData()
//          showSkills()
            mySkillsLabel.text = "My Skills (\(skillsArray.count))"
        }
        
        appliedCountLabel.text      =   "\(  profileViewModel.profileV?.totalAppliedJobs ?? 0)"
        shortListedCountLabel .text = "\(  profileViewModel.profileV?.totalShortLists ?? 0)"
        cvViewsCountLabel.text      = "\(  profileViewModel.profileV?.totalCvView ?? 0)"
       // aboutTextField.text         = profileViewModel.profileV?.about
    }
    
    func updateDropdown() {
        var titleArray: [String] = []
        for i in Constants.skills {
            let title = i.title ?? ""
            titleArray.append(title)
        }
        //self.addSkillTV.hideOptionsWhenSelect = false
        self.addSkillTV.text = ".Net Developer"
        self.addSkillTV.optionArray = titleArray
        addSkillTV.checkMarkEnabled = false
        addSkillTV.isSearchEnable = true
        addSkillTV.arrowSize = 15
        addSkillTV.arrowColor = .darkGray
        addSkillTV.listHeight = 250
        addSkillTV.selectedRowColor = .lightGray
    }
    
    func sendImageToServer (type: String, image: UIImage) {
        RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
        let params = [
            "type": type,
            "image": image
        ] as? [String: Any]
        
        guard let params = params else {return}
        
        HTTPManager.shared.multipart(APIURLs.uploadImage.rawValue, image: image, withparams: params) { (completion: GenericModelWithoutArray<uploadImageModel>?) in
            
            guard let response = completion else {return}
            
            if response.status == 200 {
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                self.getcoverPhoto = response.data?.cover_image ?? ""
                UserDefaults.standard.set(self.getcoverPhoto, forKey: "cover")
            } else {
                print("something went wrong")
            }
        }
    }
    
    func premiumMembers() {
        if profileViewModel.profileV?.isPremium == true {
            premiumImg.isHidden = false
            crownImg.isHidden = false
            premiumHeight.constant = 320
            goldenMemberLbl.isHidden = false
        } else {
            premiumImg.isHidden = true
            crownImg.isHidden = true
            goldenMemberLbl.isHidden = true
            premiumHeight.constant = 250
            
        }
    }

//        func showSkills() {
//           var index : Int = 0
//            var lineWidth : CGFloat = 8.0
//           var lineCount : Int = 1
//            let screenSize = UIScreen.main.bounds.size
//            let skillsViewWidth = screenSize.width - 32
//           for skill in skillsArray {
//
//                let skillView = UIView()
//                let skillBtn = UIButton()
//                let skillLabel = UILabel()
//
//                skillLabel.font = StyleGuide.fontPoppinsRegularWithSize(size: 12)
//                skillLabel.textColor = .white
//                skillLabel.text = skill
//                let labelWidth : CGFloat = skillLabel.intrinsicContentSize.width
//
//
//                let remainingSpace : CGFloat = skillsViewWidth - lineWidth
//                let newLabelWidth : CGFloat = (labelWidth + 38) + 8
//                if(remainingSpace > newLabelWidth){
//                    xPos = lineWidth
//                    lineWidth += ((labelWidth + 38) + 8)
//                }
//                else{
//                    yPos += 38
//                    xPos = 8
//                    lineWidth = ((labelWidth + 38) + 16)
//                    lineCount += 1
//                }
//               skillsViewHight.constant = 100
//                //skillsViewHight.constant = CGFloat((48 * lineCount))
//
//                skillView.frame = CGRect(x: xPos, y: yPos, width: labelWidth + 38, height: 30)
//                skillView.cornerRadius = 10
//                skillView.backgroundColor = UIColor(red: 0.133, green: 0.733, blue: 0.527, alpha: 1)
//                skillBtn.frame = CGRect(x: skillView.frame.size.width-30, y: 0, width: 30, height: 30)
//
//                skillLabel.frame = CGRect(x: 8, y: 0, width: labelWidth, height: 30)
//               // skillBtn.tag = index
//               // skillBtn.setTitle("x", for: .normal)
//                //skillBtn.setTitleColor(.white,for: .normal)
//               // skillBtn.addTarget(self,action:#selector(removeButtonClicked),
//                                  // for:.touchUpInside)
//                skillView.addSubview(skillLabel)
//                //skillView.addSubview(skillBtn)
//                self.mySkillsView.addSubview(skillView)
//                index = index + 1
//            }
//        }

//        @objc func removeButtonClicked(sender:UIButton)
//        {
//            skillsArray.remove(at: sender.tag)
//            for view in self.skillsView.subviews{
//                view.removeFromSuperview()
//            }
//            xPos = 8
//            yPos = 8
//            showSkills()
//            //self.jobFeedsTableView.reloadRows(at: [indexPath], with: .none)
//        }
    
    //MARK: - Delegate Methods
    func applyForJobTapped(jobID:Int?){
        RIG.NavigationManager.navigateToJobDetailsViewController(jobID: jobID ?? 0, viewController: self)
    }
    func getAppliedJobs(lastID:Int?,limit:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = AppliedJobsParams()
            params.lastID = lastID
            params.limit = limit
            profileViewModel.getAppliedJobsAPI(appliedJobsParams: params) { (responseData) in
                
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if responseData?.status == APIStatus.Success.rawValue
                {
                    //                    self.profileViewModel.appliedJob = (responseData?.data?.jobs)!
                    self.appliedJobTableView.reloadData()
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
        }
    }
    
    func getAppliedJob () { // working
        if RIG.NetworkManager.isNetworkReachable(viewController: self) {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            
            HTTPManager.shared.get(APIURLs.appliedJobs.rawValue) {(response: GenericModel<Feeds>?) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                
                guard let res = response else {return}
                if res.status == 200 {
                    self.profileViewModel.appliedJob = (res.data)!
                    print(self.profileViewModel.appliedJob)
                    if self.profileViewModel.appliedJob.count == 0 {
                        self.noJobLbl.isHidden = false
                        print("there is no applied job")
                    } else {
                        self.noJobLbl.isHidden = true
                    }
                    self.appliedJobTableView.reloadData()
                } else if res.status == 410 {
                    return
                }
                else {
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:"No Fetching data", okButton: true, viewController: self) { _ in }
                }
            }
        }
    }
    
    func getProfileData(profileID:Int?){ // working
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
                    self.appliedJobTableView.reloadData()
                    
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:responseData?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
        }
    }
    
    // MARK: - Action
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNewBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            self.addSkillViewHeight.constant = 136
            self.skillsViewHight.constant = 100
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
                self.addSkillTV.isHidden = false
                self.doneBtn.isHidden = false
                self.addBtn.isHidden = false
                self.addSkillView.isHidden = false
                self.addSkillsBgView.isHidden = false
                self.lblAddSkills.isHidden = false
            }
        }
    }
    
    @IBAction func aboutBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            UIView.animate(withDuration: 0.4) {
                self.about ()
            }
        }
    }
    func about () {
        self.appliedJobTableView.isHidden = true
        self.lblAppliedJob.isHidden = true
        self.lblaboutUnder.isHidden = false
        self.lbljobUnder.isHidden = true
        self.aboutView.isHidden = false
        self.noJobLbl.isHidden = true
    }
   
    
    @IBAction func jobBtnTapped(_ sender: UIButton) {
        getAppliedJob()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            UIView.animate(withDuration: 0.4) {
                self.appliedJobTableView.isHidden = false
                self.lblAppliedJob.isHidden = false
                
                
               
                
                
                self.lblaboutUnder.isHidden = true
                self.lbljobUnder.isHidden = false
                self.aboutView.isHidden = true
            }
        }
    }
    func sendUserSkillAPI(completion: @escaping () -> Void ){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            skillIntArray = [213,913,532]
            
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            registrationViewModel.sendUserSkillsAPI(userSkillArray: skillIntArray) { (response) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if response?.status == APIStatus.Success.rawValue
                {
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in
                        RIG.DataManager.isCompanyLoggedIn = false
                        RIG.DataManager.isUserLoggedIn = true
                        completion()
                    }
                    
                    
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")
                
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
        }
    }
    
    @IBAction func addSkillTapped(_ sender: UIButton) {
        
        
        if let skill = addSkillTV.text {
            if skillsArray.contains(where: {$0 == "\(skill)"}) {
                let array = skillsArray.filter({$0 != "\(skill)"})
                self.skillsArray = array
                showAlert(title: "Message", message: "Skill Already Exist")
                
            } else {
                skillsArray.append(skill)
                collectionView.reloadData()
               
                print(skillsArray)
                addSkillTV.text = nil
            }
            
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.addSkillTV.text = ".Net Developer"
            self.mySkillsLabel.text = "My Skills (\(self.skillsArray.count))"
        }
    }

    @IBAction func doneBtnTapped(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            self.addSkillViewHeight.constant = 0
            self.skillsViewHight.constant = 100
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
                self.addSkillTV.isHidden = true
                self.doneBtn.isHidden = true
                self.addBtn.isHidden = true
                self.addSkillView.isHidden = true
                self.addSkillsBgView.isHidden = true
                self.lblAddSkills.isHidden = true
            }
        }
    }
    
    @IBAction func messageBtnTapped(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Candidate", bundle: nil).instantiateViewController(identifier: "MessagesVC") as! MessagesVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func hideSkillsView() {
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
        self.addSkillViewHeight.constant = 0
        // UIView.animate(withDuration: 0.4) {
        //self.view.layoutIfNeeded()
        self.addSkillTV.isHidden = true
        self.doneBtn.isHidden = true
        self.addBtn.isHidden = true
        self.addSkillView.isHidden = true
        self.addSkillsBgView.isHidden = true
        self.lblAddSkills.isHidden = true
        //  }
        // }
    }
    
    
    // MARK: - Custom Function
    func setUserImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.userProfileIV.image = image
            }
        }
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return profileViewModel.appliedJob.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobFeedsTableViewCell") as! JobFeedsTableViewCell
        let model = JobFeedsTableViewCellModel.init(jobFeeds: profileViewModel.appliedJob[indexPath.row], viewController: self )
        if profileViewModel.appliedJob.count >= 0 {
                self.lblAppliedJob.text = "you didn't applied for any job"
            print("there is no applied job")
        } else {
            cell.JobFeedsTableViewCellModel = model
            self.lblAppliedJob.text = "My applied jobsss (\(profileViewModel.appliedJob.count) )"
        }
        
        cell.delegate = self
    return cell
        //cell.requestResponseDelegate = self
       // cell.addFavImage.image = #imageLiteral(resourceName: "onboarding1")
//        let model = JobFeedsTableViewCellModel.init(jobFeeds: profileViewModel.appliedJob[indexPath.row], viewController: self )
//        cell.JobFeedsTableViewCellModel =  model
//        cell.delegate = self
//        //uncommitted
//        cell.addFavBtn.tag = indexPath.row
//        cell.addFavImage.tag = indexPath.row
//        cell.applyButton.tag = indexPath.row
//        cell.applyButton.setTitle("Applied", for: .normal)
//        cell.addFavBtn.addTarget(self,action:#selector(buttonClicked),
//                                 for:.touchUpInside)
//        //for here
//
//        cell.applyButton.addTarget(self,action:#selector(applyButtonClicked),
//                                   for:.touchUpInside)
       // return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let JobID =  profileViewModel.appliedJob[indexPath.row].id {
            RIG.NavigationManager.navigateToJobDetailsViewController(jobID:JobID, viewController: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 110
    }
    
    @objc func buttonClicked(sender:UIButton) {
        print("hello: \(sender.tag)")
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.appliedJobTableView.cellForRow(at: indexPath) as! JobFeedsTableViewCell
        cell.addFavImage.image = UIImage(named: "fav_filled_icon")
        //self.jobFeedsTableView.reloadRows(at: [indexPath], with: .none)
    }
    // again commiteed
    @objc func applyButtonClicked(sender:UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        // let cell = self.jobFeedsTableView.cellForRow(at: indexPath) as! JobFeedsTableViewCell
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "JobDetailsVC") as! JobDetailsVC
        //  vc.jobTitle = cell.jobTitleLabel.text ?? ""
        // vc.jobDescription = cell.jobDescriptionLabel.text ?? ""
        // vc.jobMatch = cell.matchLabel.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        //self.jobFeedsTableView.reloadRows(at: [indexPath], with: .none)
    }
}
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerSetup() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = view.self
            alert.popoverPresentationController?.sourceRect = view.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated:  true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let chosenImage = info[.originalImage] as? UIImage else {return}
        if button == .profile {userProfileIV.image = chosenImage}
        if button == .cover {userCoverIV.image = chosenImage}
        imagePicker.dismiss(animated: true, completion: {
            self.sendImageToServer(type: "CI", image: chosenImage)
            if RIG.DataManager.isUserLoggedIn ?? false {
                let pkiImage = UserDefaults.standard.string(forKey: "cover")
                if let image = pkiImage {
                    DispatchQueue.main.async {
                        self.userCoverIV.loadSimpleCloudImage(url: image)
                    }
                }
            }
        })
    }
    
}
extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(UINib(nibName: SkillsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SkillsCollectionViewCell.identifier)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillsCollectionViewCell.identifier, for: indexPath) as? SkillsCollectionViewCell else {
            return UICollectionViewCell() }
        //cell.cancelBtn.isHidden =
        cell.skillsLabel.text = skillsArray[indexPath.row]
        cell.cornerRadius = 15
        cell.completion = {
            self.skillsArray.remove(at: indexPath.row)
            self.mySkillsLabel.text = "My Skills (\(self.skillsArray.count))"
            self.collectionView.reloadData()
            return
        }
        return cell
        
    }
}

