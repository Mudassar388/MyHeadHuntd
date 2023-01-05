//
//  RegisterUserVC.swift
//  Rig
//
//  Created by Ale on 10/31/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import CountryPickerView
import iOSDropDown
import PDFKit

class RegisterUserVC: UIViewController, CountryPickerViewDelegate, CountryPickerViewDataSource, UITextFieldDelegate, UIDocumentInteractionControllerDelegate {
    //    var jobSkil: [userskills] = []
    //    var userDta: [userskills] = []
    var isCompany: Bool = false
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryTF.text = "\(country.name)"
    }
    var showPassword: Bool = false
    var showConfirmPassword: Bool = false
    //MARK:- IBOutlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var DesignationTF: DropDown!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var profileTopViewHeight: NSLayoutConstraint!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet var emailBottomView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet weak var designationView: UIView!
    @IBOutlet weak var designationBottomView: UIView!
    @IBOutlet var showPassImage: UIImageView!
    @IBOutlet weak var showConfirmPassImage: UIImageView!
    @IBOutlet var passwordView: UIView!
    
    @IBOutlet var passwordBottomView: UIView!
    
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var confirmPassBottomView: UIView!
    
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var countryBottomView: UIView!
    
    @IBOutlet weak var termsButton: UIButton!
    var registrationViewModel = RegistrationViewModel()
    var viewmodel = DesignationData()
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.delegate = self
        self.viewmodel.editProfileDrop() {[weak self] in
            self?.updateDropdown()
        }
        //        passwordTF.text = "12345678"
        //        confirmPassTF.text = "12345678"
        //        emailTF.text = "tester@gmail.com"
        //Dropdown()
        
        // SharedModel.sharedInstance.setStatusBarColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(confirmImageTapped(tapGestureRecognizer:)))
        
        
        showPassImage.isUserInteractionEnabled = true
        showPassImage.addGestureRecognizer(tapGestureRecognizer)
        
        showConfirmPassImage.isUserInteractionEnabled = true
        showConfirmPassImage.addGestureRecognizer(tapGestureRecognizer2)
        
//        let cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: countryTF.layer.frame.width, height: 20))
//
//        cpv.delegate = self
//        cpv.dataSource = self
//        cpv.showPhoneCodeInView = false
//        cpv.showCountryCodeInView = false
//        countryTF.delegate = self
//        countryTF.leftView = cpv
//        countryTF.leftViewMode = .always
        registerBtn.addshadowColor()
        countryPick()
        countryTF.setLeftPaddingPoints(40)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 15
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool {
//
//        guard let preText = firstNameTF.text as NSString?,
//            preText.replacingCharacters(in: range, with: string).count <= 15 else {
//            return false
//        }
//
//        return true
//    }
   
    func countryPick(){
        let cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: countryTF.layer.frame.width, height: 20))
        
        cpv.delegate = self
        cpv.dataSource = self
        cpv.showPhoneCodeInView = false
        cpv.showCountryCodeInView = false
        countryTF.delegate = self
        countryTF.addSubview(cpv)
        //countryTF.leftView = cpv
        countryTF.leftViewMode = .always
        
    }
    
    func updateDropdown() {
        
        var titleArray: [String] = []
        for i in Constants.skills {
            let title = i.title ?? ""
            titleArray.append(title)
        }
        self.DesignationTF.text = ".Net Developer"
        self.DesignationTF.optionArray = titleArray
        DesignationTF.checkMarkEnabled = false
        DesignationTF.isSearchEnable = false
        DesignationTF.arrowSize = 15
        DesignationTF.arrowColor = .darkGray
        DesignationTF.selectedRowColor = .lightGray
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
        }// And some actions
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
    
    @IBAction func backToSignIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryTF {
            return false
        }else{
            return true
        }
    }
    
    @IBAction func btnActionRegister(_ sender: UIButton) {
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddSkillsViewController")
        //        navigationController?.pushViewController(vc, animated: true)
        signUpUserAPI()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func termsButtonAction(_ sender: Any) {
        
        let path =  Bundle.main.path(forResource: "Mobile_Terms___Conditions_Final-converted", ofType: ".pdf")!
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        dc.delegate = self
        dc.presentPreview(animated: true)
        
    }
    
    func signUpUserAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            let ismail: Bool = emailTF.text!.isEmail()
            if ismail {
                RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
                var params  = UserSignUpParams()
                params.UserType = UserType.User.rawValue
                params.FirstName = firstNameTF.text
                params.LastName = lastNameTF.text
                params.Email =  emailTF.text
                params.Password = passwordTF.text
                params.Country = countryTF.text
                params.JobDesignationID = 170
                params.FCMToken = ""
                registrationViewModel.UserSignUp(userSignUpParams: params) { (signUpData) in
                    RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                    if signUpData?.status == APIStatus.Success.rawValue
                    {
                        
                        let userModel = signUpData?.data
                        var rigUser = UserModel()
                        if let UserModel = userModel{
                            rigUser = UserModel
                            UserDefaults.standard.set(rigUser.referenceCode ?? "", forKey: "ref")
                            UserDefaults.standard.set(rigUser.loginToken ?? "", forKey: "token")
                        }
                        RIG.DataManager.userRIG = rigUser
                        let token = signUpData?.data?.loginToken
                        var header = RIGHeaders()
                        header.accessToken = token
                        RIG.DataManager.headers = header
                        let vc = UIStoryboard(name: RIGStoryboards.MainStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.UploadResumeViewController) as! UploadResumeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else{
                        RIG.UIManager.showAlert(title: RIGAlerts.RIG,message:signUpData?.message, okButton: true, viewController: self) { _ in }
                    }
                } errorMessage: { message in
                    RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                    
                    
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
                }
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
    
    //    func editProfileDrop() {
    //        let designation = "designation"
    //        HTTPManager.shared.get("skill/industry?type=\(designation)") { (response: GenericModel<userskills>?) in
    //            guard let respo = response else {return}
    //            if respo.status == 200 {
    //                self.userDta = respo.data ?? []
    //                self.updateDropdown()
    //            }
    //        }
    //    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
