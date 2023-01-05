//
//  ForgotPasswordVC.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import Toast_Swift

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    var registrationViewModel = RegistrationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       // SharedModel.sharedInstance.setStatusBarColor()
        emailTF.attributedPlaceholder = NSAttributedString(string: "Enter your email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.471, green: 0.467, blue: 0.471, alpha: 1)])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func forgetPassword(){

            if RIG.NetworkManager.isNetworkReachable(viewController: self)
            {
                RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
                var params  = ForgetPasswordParams()
                params.Email = emailTF.text

                registrationViewModel.forgetPasswordAPI(ForgetPasswordParams:params) { (response) in
                    RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                    if response?.status == APIStatus.Success.rawValue
                    {
                        RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in
                            self.navigationController?.popToRootViewController(animated: true)
                        }


                    }else{
                        RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
                    }
                } errorMessage: { message in
                    RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)


                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
                }

            }
        }

    
    @IBAction func btnActionForget(_ sender: Any) {
        if (emailTF.text != "") {
            forgetPassword()
        }
    }


}
