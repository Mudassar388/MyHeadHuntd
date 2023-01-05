//
//  JobDashboardVC.swift
//  Rig
//
//  Created by Ale on 9/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class JobDashboardVC: UIViewController {

    //MARK:- Variables
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var statsView: UIView!
    
    @IBOutlet weak var userProfileIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        designationTF.attributedPlaceholder = NSAttributedString(string: "Position",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)])
        
        locationTF.attributedPlaceholder = NSAttributedString(string: "Location",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)])
        
        statsView.layer.shadowColor = UIColor.black.cgColor
        statsView.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        statsView.layer.shadowOpacity = 0.25;
        statsView.layer.masksToBounds = false;
        
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods -
    
    fileprivate func setLayout(){
        var fullName: String = ""
        if let designation = AppSingleton.shared.currentCompany?.data?.company?.company_name{
            designationLbl.text = designation
        }
        
        if let uName = AppSingleton.shared.currentCompany?.data?.company?.first_name{
            fullName = uName
            nameLbl.text = uName
        }
        if let lName = AppSingleton.shared.currentCompany?.data?.company?.last_name{
            fullName = fullName + " " + lName
            nameLbl.text = fullName
        }
        
        if let ivProfile = AppSingleton.shared.currentCompany?.data?.company?.filesource{
            
            setUserImage(from: ivProfile)
            
        }
    }
    
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
    
    //minExperience: minimumExperienceTF.text ?? "",
    //maxExperience: maximumExperienceTF.text ?? "",
    //jobType: jobTypeTF.text ?? "",
//    func searchJob(){
//        //Need desgination parameter
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Please wait..."
//        hud.show(in: self.view)
//        Repository.searchJob(location: locationTF.text ?? "") { (status, data, message) in
//            hud.dismiss()
//            if status{
//                if (data?.serchresult?.count ?? 0) > 0{
//                    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "SearchJobResultVC") as! SearchJobResultVC
//                    vc.searchJobResults = data?.serchresult
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    print("No jobs found")
//                }
//            }else{
//                print("Could not get jobs")
//            }
//        }
//    }
//
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSearch(_ sender: UIButton) {
       // searchJob()
    }
    
    @IBAction func postJobAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Candidate", bundle: nil).instantiateViewController(identifier: "PostJobVC") as! PostJobVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
