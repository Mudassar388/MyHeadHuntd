//
//  CompanySettingVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class CompanySettingVC: UIViewController {

    //MARK:- Variables
    
    
    //MARK:- IBOutlets
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods
    
    //MARK:- IBActions
    @IBAction func btnActionSearchCandidate(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Candidate", bundle: nil).instantiateViewController(identifier: "JobDashboardVC") as! JobDashboardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
