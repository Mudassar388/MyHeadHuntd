//
//  JobDetailsVC.swift
//  Rig
//
//  Created by STC Macbook Pro on 03/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class JobDetailsVC: UIViewController {
    
    @IBOutlet weak var jobImage: UIImageView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var skillsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var jobDetailViewModel = JobDetailsViewModel()
    var headingArray  : [String] = []
    var detailsArray  : [String] = []
    var jobIDForDetails : Int?
    //var objData: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getJobDetailApi(jobID: jobIDForDetails)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        registerSkillXib()
        
        //        skillsArray.append("Android")
        //        skillsArray.append("XML")
        //        skillsArray.append("JAVA")
        //        skillsArray.append("JDK")
        //        skillsArray.append("Kotlin")
        //        skillsArray.append("Retrofit")
        
        
        headingArray.append("Industry")
        headingArray.append("Functional area")
        headingArray.append("Total Positions")
        headingArray.append("Job Shift")
        headingArray.append("Job Type")
        headingArray.append("Job location")
        headingArray.append("Gender")
        headingArray.append("Minumum education")
        headingArray.append("Minumum experience")
        headingArray.append("Apply before")
        
        //        detailsArray.append("Information technology")
        //        detailsArray.append("Software and web development")
        //        detailsArray.append("3")
        //        detailsArray.append("Day")
        //        detailsArray.append("Permanent")
        //        detailsArray.append("London")
        //        detailsArray.append("Male")
        //        detailsArray.append("Mar-21-2021")
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        if jobDetailViewModel.jobDetailsData?.isApplied == false {
            applyJobAPI(JobID:jobIDForDetails)
        }
        
    }
    
    func registerXib() {
        skillsCollectionView.register(UINib(nibName: "SkillsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SkillsCollectionViewCell")
    }
    
    func registerSkillXib() {
        detailTableView.register(UINib(nibName: "JobDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDetailsTableViewCell")
    }
    // MARK: - JobDetail APi Calling
    func getJobDetailApi(jobID:Int?)  {
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = JobDetailsParams()
            params.jobID = jobID
            jobDetailViewModel.getJobDetailsAPI(jobDetailsParams: params) {  (jobDetailResponse) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if jobDetailResponse?.status == APIStatus.Success.rawValue
                {
                    self.jobDetailViewModel.jobDetailsData = (jobDetailResponse?.data)!
                    self.assignDataToLables()
                    self.skillsCollectionView.reloadData()
                    self.detailTableView.reloadData()
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:jobDetailResponse?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                print (message ?? "")
                
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
            
            
        }
    }
    func assignDataToLables(){
        
        if jobDetailViewModel.jobDetailsData?.isApplied ?? false {
            self.applyBtn.setTitle("Applied", for: .normal)
            self.applyBtn.isUserInteractionEnabled = false
        }
        //  jobImage.loadSimpleCloudImage(url:jobDetailViewModel.jobDetailsData.jobImage)
        jobTitleLabel.text = jobDetailViewModel.jobDetailsData?.title ?? ""
        jobDescriptionLabel.text = jobDetailViewModel.jobDetailsData?.companyName ?? ""
        if jobDetailViewModel.jobDetailsData?.totalMatchedSkills == 1 || jobDetailViewModel.jobDetailsData?.totalMatchedSkills == 0 {
            matchLabel.text = "\(jobDetailViewModel.jobDetailsData?.totalMatchedSkills ?? 0) Skill Matched"
        }else{
            matchLabel.text = "\(jobDetailViewModel.jobDetailsData?.totalMatchedSkills ?? 0) Skills Matched"
        }
        descriptionText.text = jobDetailViewModel.jobDetailsData?.dataDescription ?? ""
        
        detailsArray.append(jobDetailViewModel.jobDetailsData?.industry?.name ?? "")
        detailsArray.append(jobDetailViewModel.jobDetailsData?.functionalArea ?? "")
        detailsArray.append(String(jobDetailViewModel.jobDetailsData?.totalPositions ?? 0))
        detailsArray.append(jobDetailViewModel.jobDetailsData?.jobShift ?? "")
        detailsArray.append(jobDetailViewModel.jobDetailsData?.jobType ?? "")
        detailsArray.append(jobDetailViewModel.jobDetailsData?.jobLocation ?? "")
        detailsArray.append(jobDetailViewModel.jobDetailsData?.gender ?? "")
        detailsArray.append(jobDetailViewModel.jobDetailsData?.education ?? "")
        //  detailsArray.append(jobDetailViewModel.jobDetailsData?.careerLevel ?? "")
        detailsArray.append("\(jobDetailViewModel.jobDetailsData?.minExperience ?? "") years")
        detailsArray.append(RIG.DataManager.dateFromString(timeString:  jobDetailViewModel.jobDetailsData?.lastApplyDate ?? "", withFormatIN: "yyyy-MM-dd'T'HH:mm:ss", andFormatOut: "MMM-dd-yyyy") ?? "")
        //    detailsArray.append(jobDetailViewModel.jobDetailsData.jobDetail ?? "")
        
    }
    
    
    func applyJobAPI(JobID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = ApplyJobParams()
            params.jobID = JobID
            
            jobDetailViewModel.applyToJobApi(ApplyJobParams: params) {(applyjobResponse) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if applyjobResponse?.status == APIStatus.Success.rawValue
                {
                    self.jobDetailViewModel.applyJobData = applyjobResponse?.data
                    if self.jobDetailViewModel.applyJobData?.status == "A"{
                        self.applyBtn.setTitle("Applied", for: .normal)
                        self.applyBtn.isUserInteractionEnabled = false
                        self.getJobDetailApi(jobID: self.jobIDForDetails)
                    }
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:applyjobResponse?.message, okButton: true, viewController: self ) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller:self)
                print (message ?? "")
                
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self ) { _ in }
            }
        }
        
        
        
    }
    
    
}

extension JobDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  jobDetailViewModel.jobDetailsData?.skills?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillsCollectionViewCell", for: indexPath) as! SkillsCollectionViewCell
        let objData = jobDetailViewModel.jobDetailsData?.skills?[indexPath.row]
        cell.cancelBtn.isHidden = true
        cell.skillsLabel.text = objData?.title
        cell.cornerRadius = 15
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
        return CGSize(width: 100, height: 30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailsTableViewCell", for: indexPath) as! JobDetailsTableViewCell
        cell.headingLabel.text = headingArray[indexPath.row]
        if jobDetailViewModel.jobDetailsData != nil{
            cell.skillLabel.text   = detailsArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
