//
//  ChooseVC.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class ChooseVC: UIViewController {

    @IBOutlet var companyButton: UIButton!
    @IBOutlet var userButton: UIButton!
    var myString:NSString = "Headhuntd"
    var myMutableString = NSMutableAttributedString()
    @IBOutlet var headingText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //button.layer.shadowRadius = 3.0f;
        
       // SharedModel.sharedInstance.setStatusBarColor()
        userButton.layer.shadowColor = UIColor.black.cgColor
        userButton.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        userButton.layer.shadowOpacity = 0.25;
        userButton.layer.masksToBounds = false;
        
        companyButton.layer.shadowColor = UIColor.black.cgColor
        companyButton.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        companyButton.layer.shadowOpacity = 0.25;
        companyButton.layer.masksToBounds = false;
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func btnActionIndividual(_ sender: UIButton) {
        RIG.DataManager.isUserPressed = true
        RIG.DataManager.isCompanyPressed = false
    }
    
    @IBAction func btnActionCompany(_ sender: UIButton) {
        RIG.DataManager.isCompanyPressed = true
        RIG.DataManager.isUserPressed = false
    }

}
