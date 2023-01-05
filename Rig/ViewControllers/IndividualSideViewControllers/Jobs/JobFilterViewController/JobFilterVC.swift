//
//  JobFilterVC.swift
//  Rig
//
//  Created by STC Macbook Pro on 24/03/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
import iOSDropDown


class JobFilterVC: UIViewController {

    var delegate: ModalDelegate?
    
    var filterObj = JobFeedParams()
    
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var skillMatchTF: DropDown!
    @IBOutlet weak var jobTypeTF: DropDown!
    @IBOutlet weak var minExperienceTF: DropDown!
    @IBOutlet weak var maxExperienceTF: DropDown!
    @IBOutlet weak var genderTF: DropDown!
    @IBOutlet weak var careerLevelTF: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //SharedModel.sharedInstance.setStatusBarColor()
        
        updateView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func applyFilterAction(_ sender: Any) {
        
        filterObj.location = locationTF.text
        
        NotificationCenter.default.post(name: NSNotification.Name("FilterNotificationIdentifier"), object: nil, userInfo: ["obj": filterObj])
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    // MARK: - Custom Function
    
    func updateView() {
        
        locationTF.attributedPlaceholder = NSAttributedString(string: "Set Location",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.60, green: 0.67, blue: 0.74, alpha: 1.00)])
        
            
        
        skillMatchTF.optionArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        skillMatchTF.isSearchEnable = false
        skillMatchTF.selectedRowColor = .lightGray
        skillMatchTF.arrowSize = 15
        skillMatchTF.text = "2"
        minExperienceTF.optionArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "10+"]//["1-2 Years"]
        minExperienceTF.isSearchEnable = false
        minExperienceTF.selectedRowColor = .lightGray
        minExperienceTF.arrowSize = 15
        minExperienceTF.text = "1"
        
        maxExperienceTF.optionArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "10+"]
        maxExperienceTF.isSearchEnable = false
        maxExperienceTF.selectedRowColor = .lightGray
        maxExperienceTF.arrowSize = 15
        maxExperienceTF.text = "4"
        
        
        
        jobTypeTF.optionArray = ["Full Time", "Part Time", "Internship", "Temporary"]
        jobTypeTF.isSearchEnable = false
        jobTypeTF.selectedRowColor = .lightGray
        jobTypeTF.arrowSize = 15
        jobTypeTF.text = "Full Time"
        jobTypeTF.didSelect{(_ , index ,_) in
            self.jobTypeTF.selectedIndex = index + 1
            self.filterObj.jobType = index
            
    }
        
        genderTF.optionArray = ["Male", "Female", "Shemale"]
        genderTF.isSearchEnable = false
        genderTF.selectedRowColor = .lightGray
        genderTF.arrowSize = 15
        genderTF.text = "Male"
        genderTF.didSelect{(_ , index ,_) in
            self.genderTF.selectedIndex = index + 1
            self.filterObj.gender = index
            
    }
        
        
        
        careerLevelTF.optionArray = ["Professional", "Non Professional"]
        careerLevelTF.isSearchEnable = false
        careerLevelTF.selectedRowColor = .lightGray
        careerLevelTF.arrowSize = 15
        careerLevelTF.text = "Professional"
        careerLevelTF.didSelect{(_ , index ,_) in
            self.careerLevelTF.selectedIndex = index
            if index == 0 {
                self.filterObj.careerLevel = "Professional"
            } else {
                self.filterObj.careerLevel = "Non Professional"
            }
            
            
    }
        
    }
    // MARK: - API Calling

}
