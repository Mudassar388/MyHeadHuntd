//
//  AboutUsViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 13.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import Alamofire

class AboutUsViewController: UIViewController {

    @IBOutlet weak var descreiptionLabel:UILabel!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var NavtitleLabel:UILabel!
    @IBOutlet weak var image:UIImageView!
    var aboutUsViewModel = AboutUsViewModel()
    var pagetitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()


//        For Privacy Policy Page => privacy-policy
//        For About Us => about-us
//        For Terms and conditions => terms-and-conditions
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NavtitleLabel.text = pagetitle
        titleLabel.text = pagetitle
        if pagetitle == PageTitle.AboutUS.rawValue{
            image.image = UIImage(named: "AboutUs")
        } else if  pagetitle == PageTitle.TermsAndConditions.rawValue{
            image.image = UIImage(named: "Terms")
        }else if  pagetitle == PageTitle.PrivacyPolicy.rawValue{
            image.image = UIImage(named: "PravicyPolicy")

        }
        getpagesAPI()
    }

    @IBAction func Back(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func getpagesAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            var params  = PagesParam()
            if pagetitle == PageTitle.AboutUS.rawValue{
                params.slug = "about-us"

            } else if  pagetitle == PageTitle.TermsAndConditions.rawValue{
                params.slug = "terms-and-conditions"

            }else if  pagetitle == PageTitle.PrivacyPolicy.rawValue{
                params.slug = "privacy-policy"

            }

            aboutUsViewModel.getpageAPi(PagesParam: params) { responsedata in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                if responsedata?.status == APIStatus.Success.rawValue
                {
                    self.aboutUsViewModel.pageModel = responsedata
                    self.descreiptionLabel.text  = self.aboutUsViewModel.pageModel?.data?.dataDescription.base64Decoded()?.withoutHtml
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:responsedata?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                print (message ?? "")

                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }




        }
    }

}
