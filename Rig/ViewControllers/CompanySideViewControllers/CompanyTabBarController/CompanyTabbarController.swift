//
//  CompanyTabbarController.swift
//  Rig
//
//  Created by Mac on 11/05/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class CompanyTabbarController: UITabBarController {


        override func viewDidLoad() {
            super.viewDidLoad()

           // SharedModel.sharedInstance.setStatusBarColor()
            tabBar.layer.shadowOffset = CGSize(width: 10, height: 10)
            tabBar.layer.shadowRadius = 2
            tabBar.layer.shadowColor = UIColor.black.cgColor
            tabBar.layer.shadowOpacity = 0.6

            tabBar.backgroundColor = UIColor.white

            tabBar.clipsToBounds = true
            tabBar.layer.cornerRadius = 15
            tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

            view.bringSubviewToFront(tabBar)


        }

        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
        {
            self.view.window?.rootViewController?.navigationController?.popToRootViewController(animated: false)
        }


    }


