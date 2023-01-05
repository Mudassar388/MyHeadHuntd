//
//  IndividualVC.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class IndividualVC: UIViewController {
    

    var showPassword: Bool = false
    
    //MARK:- IBOutlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signUpLine: UIView!
    @IBOutlet weak var signInLine: UIView!
    @IBOutlet var emailBottomView: UIView!
    @IBOutlet var emailView: UIView!
    
    @IBOutlet var showPassImage: UIImageView!
    
    @IBOutlet var passwordView: UIView!
  
    @IBOutlet var passwordBottomView: UIView!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    var registrationViewModel = RegistrationViewModel()
    static let sharedInstance = IndividualVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        showPassImage.isUserInteractionEnabled = true
        showPassImage.addGestureRecognizer(tapGestureRecognizer)
        
//        signInBtn.layer.shadowColor = UIColor.black.cgColor
//        signInBtn.layer.shadowOffset = CGSize(width:0.0, height:2.0);
//        signInBtn.layer.shadowOpacity = 0.25;
//        signInBtn.layer.masksToBounds = false;
        
        #if DEBUG
        if RIG.DataManager.isUserPressed ?? false{
            emailTF.text = "Newuser@gmail.com"
            passwordTF.text = "11111111"
        }else  if RIG.DataManager.isCompanyPressed ?? false{
            emailTF.text = "sikandarali307@gmail.com"
            passwordTF.text = "12345678"
        }
        #endif

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == showPassImage) {
            if(showPassword) {
                showPassword = false
                showPassImage.image = UIImage(named: "show_pass_icon")
                passwordTF.isSecureTextEntry = true;
            } else {
                showPassword = true
                showPassImage.image = UIImage(named: "hide_pass_icon")
                passwordTF.isSecureTextEntry = false;
            }
        }
        // And some actions
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    //MARK: - button tapped
    @IBAction func btnActionForgotPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnActionSIgnIn(_ sender: UIButton) {
        if RIG.DataManager.isCompanyPressed ?? false{
            companyLoginAPI()
        }else if RIG.DataManager.isUserPressed ?? false{
            userLoginAPI()
           
        }else{
            RIG.UIManager.showAlert(title: RIGAlerts.RIG, message: "Invalid", okButton: true, viewController: self) { _ in }
        }

    }

    @IBAction func btnActionRegister(_ sender: UIButton) {
        if RIG.DataManager.isCompanyPressed ?? false{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterVC") as! RegisterVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if RIG.DataManager.isUserPressed ?? false{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterUserVC") as! RegisterUserVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }




    //MARK: - user Login API
    
    func saveFcmTokenAPI() {
        
        let fcm = UserDefaults.standard.string(forKey: "deviceID")
        
        let params = [
            "fcm_token": fcm as Any
        ] as [String: Any]
        
        HTTPManager.shared.post(APIURLs.saveDeviceToken.rawValue, withparams: params, noHeaders: false) { (resp: Refferal?) in
            guard let response = resp else {return}
            
            if response.status == 200 {
                print("Respone-Message",response.message as Any)
//                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response.message, okButton: true, viewController: self) { _ in }
            } else {
//                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message: "Failed Url Session", okButton: true, viewController: self) { _ in }
            }
            
        }
    }
    
    
    func userLoginAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            let ismail: Bool = emailTF.text!.isEmail()
            let fcm = UserDefaults.standard.string(forKey: "deviceID")
            if ismail {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            var params  = LoginParams()
            params.Email = emailTF.text
            params.Password = passwordTF.text
            params.UserType = UserType.User.rawValue
            params.FCMToken = fcm

            registrationViewModel.UserLoginAPI(UserLoginParams: params) { (response) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if response?.status == APIStatus.Success.rawValue
                {
                    RIG.DataManager.isCompanyLoggedIn = false
                    RIG.DataManager.isUserLoggedIn = true
                    let userModel                  = response?.data
                    var rigModel                    = UserModel()
                    if let UserModeldata = userModel{
                        rigModel    = UserModeldata
                    }
                    RIG.DataManager.userRIG    = rigModel
                    let token = response?.data?.loginToken
                    guard let premiuim = response?.data?.isPremium else {return}
                    UserDefaults.standard.set(premiuim, forKey: "isPremium")
                    UserDefaults.standard.set(rigModel.referenceCode ?? "", forKey: "ref")
                    UserDefaults.standard.set(token ?? "", forKey: "token")
                    var header = RIGHeaders()
                    header.accessToken = token
                    RIG.DataManager.headers = header
                    
                    RIG.NavigationManager.setUpFirstScreen()

                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)


                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
               }
        }
    }
    //MARK: - companyLogin API
    func companyLoginAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            let ismail: Bool = emailTF.text!.isEmail()
            if ismail {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            var params  = LoginParams()
            params.Email = emailTF.text
            params.Password = passwordTF.text
            params.UserType = UserType.Company.rawValue
            params.FCMToken = ""

            registrationViewModel.CompanyLoginAPI(companyLoginParams: params) { (response) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if response?.status == APIStatus.Success.rawValue
                {
                    RIG.DataManager.isCompanyLoggedIn = true
                    RIG.DataManager.isUserLoggedIn = false
                    let companyModel                  = response?.data
                    var rigModel                    = CompanyModel()
                    if let CompanyModeldata = companyModel{
                        rigModel    = CompanyModeldata
                    }
                    RIG.DataManager.companyDataRIG    = rigModel
                    let token = response?.data?.loginToken
                    var header = RIGHeaders()
                    header.accessToken = token
                    RIG.DataManager.headers = header
                    RIG.NavigationManager.setUpFirstScreen()

                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)


                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }
               }
        }
    }
 
    
}
