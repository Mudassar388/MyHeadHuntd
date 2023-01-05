//
//  CompanyLoginVC.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class CompanyLoginVC: UIViewController {

    //MARK:- Variables
    var isCompany: Bool = false
    
    //MARK:- IBOutlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SharedModel.sharedInstance.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    
    //    user side
    //    ali1122@mailinator.com
    //    12345678
        
    //    company side
    //    paktech@gmail.com
    //    qqqqqq
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
     
    //MARK:- IBActions
    @IBAction func btnActionForgotPassword(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func compannySignUp(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnActionSIgnIn(_ sender: UIButton) {
//        if isCompany{
//            companyLoginCall()
//        }else{
//            individualLoginCall()
//        }
//        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "MyTabbarController") as! MyTabbarController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
 

}
