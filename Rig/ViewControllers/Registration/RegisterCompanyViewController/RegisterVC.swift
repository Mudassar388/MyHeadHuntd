//
//  RegisterVC.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import iOSDropDown

class RegisterVC: UIViewController, UITextFieldDelegate, UIDocumentInteractionControllerDelegate {
    
    var showPassword: Bool = false
    var showConfirmPassword: Bool = false
    
    @IBOutlet weak var profileTopViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileTopView: UIView!
    
    @IBOutlet weak var companyDetailView: UIView!
    @IBOutlet weak var personTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var siteUrlTF: UITextField!
    
    @IBOutlet weak var companySizeTF: DropDown!
    
    @IBOutlet weak var industryTF: DropDown!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var personBottomView: UIView!
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var emailBottomView: UIView!
    
    @IBOutlet var passwordView: UIView!
    @IBOutlet var passwordBottomView: UIView!
    
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var confirmPassBottomView: UIView!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countryBottomView: UIView!
    
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var companyNameBottomView: UIView!
    
    @IBOutlet weak var siteUrlView: UIView!
    @IBOutlet weak var siteUrlBottomView: UIView!
    
    @IBOutlet weak var companySizeView: UIView!
    @IBOutlet weak var companySizeBottomView: UIView!
    
    @IBOutlet weak var industryView: UIView!
    @IBOutlet weak var industryBottomView: UIView!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressBottomView: UIView!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionBottomView: UIView!
    
    @IBOutlet var showPassImage: UIImageView!
    @IBOutlet weak var showConfirmPassImage: UIImageView!
       
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var termsButton: UIButton!
    
    @IBOutlet weak var termsLabel: UILabel!

     var registrationViewModel = RegistrationViewModel()

    var ID : [Int] = []
    var id = 0
    
    override func viewWillAppear(_ animated: Bool) {
        getSkillIndustryApi()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // SharedModel.sharedInstance.setStatusBarColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(confirmImageTapped(tapGestureRecognizer:)))
        
        showPassImage.isUserInteractionEnabled = true
        showPassImage.addGestureRecognizer(tapGestureRecognizer)
        
        showConfirmPassImage.isUserInteractionEnabled = true
        showConfirmPassImage.addGestureRecognizer(tapGestureRecognizer2)
        
        registerBtn.layer.shadowColor = UIColor.black.cgColor
        registerBtn.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        registerBtn.layer.shadowOpacity = 0.25;
        registerBtn.layer.masksToBounds = false;
    
//        personTF.attributedPlaceholder = NSAttributedString(string: "Contact Person Name",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        emailTF.attributedPlaceholder = NSAttributedString(string: "Email Address",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        passwordTF.attributedPlaceholder = NSAttributedString(string: "Password",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        confirmPassTF.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        companyNameTF.attributedPlaceholder = NSAttributedString(string: "Company Name",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        siteUrlTF.attributedPlaceholder = NSAttributedString(string: "Website URL",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//
//        companySizeTF.attributedPlaceholder = NSAttributedString(string: "Select Company Size",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        industryTF.attributedPlaceholder = NSAttributedString(string: "Select Industry",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        addressTF.attributedPlaceholder = NSAttributedString(string: "Address",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
//
//        descriptionTF.attributedPlaceholder = NSAttributedString(string: "Short Descritopn",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00)])
        updateDropdown()
        companySizeTF.optionArray = ["1-10", "10-50", "50-200"]
        //industryTF.optionArray = ["Information Technology", "Sales/Marketing", "Busniness Development"]
        //Its Id Values and its optional

        // Do any additional setup after loading the view.
        personTF.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == showPassImage) {
            if(showPassword){
                showPassword = false
                showPassImage.image = UIImage(named: "show_pass_icon")
                passwordTF.isSecureTextEntry = true;
            }
            else{
                showPassword = true
                showPassImage.image = UIImage(named: "hide_pass_icon")
                passwordTF.isSecureTextEntry = false;
            }
        }
    }
    var jobSkill: [JobSkills] = []
    func updateDropdown() {
        
        var titleArray: [String] = []
        for i in jobSkill {
            let title = i.title ?? ""
            titleArray.append(title)
        }
        if industryTF.text == "" {
            self.industryTF.text = ".Net Developer"
        }
        self.industryTF.optionArray = titleArray
    }
    
    
    
    @objc func confirmImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == showConfirmPassImage) {
            if(showConfirmPassword){
                showConfirmPassword = false
                showConfirmPassImage.image = UIImage(named: "show_pass_icon")
                confirmPassTF.isSecureTextEntry = true;
            }
            else{
                showConfirmPassword = true
                showConfirmPassImage.image = UIImage(named: "hide_pass_icon")
                confirmPassTF.isSecureTextEntry = false;
            }
        }
           // And some actions
    }
    @IBAction func termsButtonAction(_ sender: Any) {
        let path =  Bundle.main.path(forResource: "Mobile_Terms___Conditions_Final-converted", ofType: ".pdf")!
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       return true
    }
    
    @IBAction func backBtnSignin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionRegister(_ sender: UIButton) {
        signUpCompanyAPI()

    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getIndustryInteger(selectedIndustry:String) -> Int?{
        var industryINT :Int?
        if selectedIndustry != ""{
            for i in registrationViewModel.industrySkillModel?.data ?? []{
                if selectedIndustry == i.name
                {
                    print(selectedIndustry)
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
    
    func signUpCompanyAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")

            var params  = CompanySignUpParams()
            params.FirstName = "sikandar"
            params.LastName = "ali"
            params.UserType = UserType.Company.rawValue
            params.ContactPerson = personTF.text
            params.Email = emailTF.text
            params.Password = passwordTF.text
            params.CompanyName = companyNameTF.text
            params.WebsiteUrl = siteUrlTF.text
            params.CompanySize = companySizeTF.text
//            params.IndustryId =  getIndustryInteger(selectedIndustry:industryTF.text ?? "")
//            params.IndustryId = industryTF.selectedIndex ?? 0 - 1
            params.IndustryId = self.ID[industryTF.selectedIndex ?? 0]

            params.Address = addressTF.text
            params.Description = descriptionTF.text
            
            print(params)

            registrationViewModel.companySignUp(companySignUpParams: params) { (signUpData) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if signUpData?.status == APIStatus.Success.rawValue
                {
                    RIG.DataManager.isCompanyLoggedIn = true
                    RIG.DataManager.isUserLoggedIn = false
                    let companyModel                  = signUpData?.data
                    var rigCompany                    = CompanyModel()
                    if let CompanyModel = companyModel{
                        rigCompany    = CompanyModel
                    }
                    RIG.DataManager.companyDataRIG    = rigCompany
                    let token = signUpData?.data?.loginToken
                    var header = RIGHeaders()
                    header.accessToken = token
                    RIG.DataManager.headers = header
                    RIG.NavigationManager.setUpFirstScreen()
                    

                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:signUpData?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)


                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }

        }
    }

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
                        var industryID : [Int] = []
                        for i in self.registrationViewModel.industrySkillModel?.data ?? []{

                            IndustryData.append(i.name ?? "")
                            industryID.append(i.id ?? 0)
                            self.ID = industryID
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


    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }

    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }

    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
}
