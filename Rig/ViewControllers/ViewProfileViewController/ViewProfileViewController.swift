//
//  ViewProfileViewController.swift
//  Rig
//
//  Created by Mac on 29/05/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class ViewProfileViewController: UIViewController {

    @IBOutlet weak var ProfileImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if RIG.DataManager.isUserLoggedIn ?? false{
            let pkiImage = UserDefaults.standard.string(forKey: "image")
            if let image = pkiImage {
                ProfileImage.loadSimpleCloudImage(url: image)
            }

        }else if RIG.DataManager.isCompanyLoggedIn ?? false{
            if  let image =  RIG.DataManager.companyDataRIG?.profileImage {

                ProfileImage.loadSimpleCloudImage(url:image)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
