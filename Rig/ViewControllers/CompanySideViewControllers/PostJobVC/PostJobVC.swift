//
//  PostJobVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import iOSDropDown


class PostJobVC: UIViewController {

 
    //MARK:- Variables
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var industryTF: DropDown!
    @IBOutlet weak var jobTitleTf: UITextField!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var jobTypeTF: DropDown!
    @IBOutlet weak var salaryCurrencyTF: DropDown!
    @IBOutlet weak var salaryTF: DropDown!
    @IBOutlet weak var minExperienceTF: UITextField!
    @IBOutlet weak var maxExperienceTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var eduLevelTF: UITextField!
    @IBOutlet weak var reqSkillsTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    var postJobViewModel = PostJobViewModel()
    var registrationViewModel = RegistrationViewModel()
    //MARK:- View Controller Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        getSkillIndustryApi()
        updatedrop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameTF.attributedPlaceholder = NSAttributedString(string: "Enter Company Name",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        industryTF.attributedPlaceholder = NSAttributedString(string: "Select Industry",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        positionTF.attributedPlaceholder = NSAttributedString(string: "Add Position",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        jobTypeTF.attributedPlaceholder = NSAttributedString(string: "Select Job Type",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        salaryCurrencyTF.attributedPlaceholder = NSAttributedString(string: "$ (ARS)",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        salaryTF.attributedPlaceholder = NSAttributedString(string: "Salary",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        minExperienceTF.attributedPlaceholder = NSAttributedString(string: "Min",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        maxExperienceTF.attributedPlaceholder = NSAttributedString(string: "Max",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        locationTF.attributedPlaceholder = NSAttributedString(string: "Enter Location",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        jobTitleTf.attributedPlaceholder = NSAttributedString(string: "Enter Job Title",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        eduLevelTF.attributedPlaceholder = NSAttributedString(string: "Enter Education Level",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        reqSkillsTF.attributedPlaceholder = NSAttributedString(string: "Enter Required Skill",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
        descriptionTF.attributedPlaceholder = NSAttributedString(string: "Enter Job Description",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        updateTf ()
        // Do any additional setup after loading the view.
    }
    func updateTf () {
        salaryTF.checkMarkEnabled = true
        salaryTF.isSearchEnable = true
        salaryTF.arrowSize = 15
        salaryTF.arrowColor = .darkGray
        salaryTF.selectedRowColor = .lightGray
    }
    
    //MARK:- Custom Methods
    
    private func postJob(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: view)
        Repository.postJob(industry: industryTF.text ?? "", position: positionTF.text ?? "", jobType: jobTypeTF.text ?? "", salary: salaryTF.text ?? "", minExperience: minExperienceTF.text ?? "", maxExperience: maxExperienceTF.text ?? "", location: locationTF.text ?? "") { (status, data, message) in
            hud.dismiss()
            if status{
                print("Job Posted Successfully")
            }else{
                print("Unable to post job")
            }
        }
    }
    func updatedrop() {
        jobTypeTF.checkMarkEnabled = true
        jobTypeTF.arrowSize = 15
        jobTypeTF.optionArray = ["Full Time", "Part Time", "Internship", "Temporary"]
    }

    func setPostJobParams() ->PostJobParams{
        var params  = PostJobParams()
        params.CompanyName = companyNameTF.text
        params.Industry = Int(industryTF.text ?? "")
        params.JobTitle = positionTF.text
        params.JobType = Int( jobTypeTF.text ?? "")
        params.SalaryCurrency = Int(salaryCurrencyTF.text ?? "")
        params.MaxSalary = Int(salaryTF.text ?? "")
        params.MinExperience = Int(minExperienceTF.text ?? "")
        params.Location = locationTF.text
        params.EducationLevel = eduLevelTF.text
        params.JobTitle = jobTypeTF.text
      //  params.Skills?.append(Int(reqSkillsTF.text ?? "") ?? 0)
        params.description = descriptionTF.text
        return params
    }
    func postJobAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
 
            var params  = PostJobParams()
            params.CompanyName = companyNameTF.text
            params.Industry =  getIndustryInteger(selectedIndustry:industryTF.text ?? "")
            params.FunctionalArea = "computer"
            params.Gender  = 1
            params.JobTitle = positionTF.text
            params.JobType = 1
            params.JobShift = 1
            params.SalaryCurrency = 1
            params.MinSalary = Int(minExperienceTF.text ?? "0")
            params.MaxSalary = Int(maxExperienceTF.text ?? "0")
            params.MinExperience = 3
            params.Location = locationTF.text
            params.EducationLevel = eduLevelTF.text
            postJobViewModel.skillsForParams = [965,655,546]
            params.CareerLevel = "professional"
            params.description =  descriptionTF.text
            params.LastApplyDate = "2021-05-15"
            params.TotalPositions = 4

//            var params  = PostJobParams()
//            params.CompanyName = "Technologies"
//            params.Industry =  getIndustryInteger(selectedIndustry:industryTF.text ?? "")
//            params.FunctionalArea = "computer"
//            params.Gender  = 1
//            params.JobTitle = "Laravel"
//            params.JobType = 1
//            params.JobShift = 1
//            params.SalaryCurrency = 1
//            params.MinSalary = 123533
//            params.MaxSalary = 234324
//            params.MinExperience = 3
//            params.Location = "islsd"
//            params.EducationLevel = "master"
//            postJobViewModel.skillsForParams = [965,655,546]
//            params.CareerLevel = "professional"
//            params.description = "notjgd dskjbds sikanjskbdsdjkbsdkjbfkfdsjnbkasjbkasjcbasjcbjas casjch csa csf"
//            params.LastApplyDate = "2021-05-15"
//            params.TotalPositions = 4
            


            postJobViewModel.postJobsApi(postJobParams: params) { (postjob) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if postjob?.status == APIStatus.Success.rawValue
                {
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:postjob?.message, okButton: true, viewController: self) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }


                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:postjob?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                print (message ?? "")

                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }


        }    }
    func getIndustryInteger(selectedIndustry:String) -> Int?{
        var industryINT :Int?
        if selectedIndustry != ""{
            for i in registrationViewModel.industrySkillModel?.data ?? []{
                if selectedIndustry == i.name
                {
                    industryINT = i.id
                }else{
                    industryINT = 0
                }
            }
        }else{
            industryINT = 0
        }
        return industryINT
    }
    //MARK:- IBActions
    func getSkillIndustryApi(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
            var params  = IndustrySkillParams()
            params.type = "industry"
            registrationViewModel.getSkillIndustryApi(industrySkillParams: params) { (data) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if data?.status == APIStatus.Success.rawValue
                {
                    self.registrationViewModel.industrySkillModel = data
                    var IndustryData:[String] = []
                    for i in self.registrationViewModel.industrySkillModel?.data ?? []{

                        IndustryData.append(i.name ?? "")
                    }
                    self.industryTF.optionArray = IndustryData
                }else{
                   RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:data?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")

             RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }

        }
    }
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionPostJob(_ sender: UIButton) {
        postJobAPI()
    }
}
