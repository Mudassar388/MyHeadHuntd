//
//  MyTabbarController.swift
//  Rig
//
//  Created by Ale on 12/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class MyTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // SharedModel.sharedInstance.setStatusBarColor()
        tabBar.layer.shadowOffset = CGSize(width: 10, height: 10)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.6
        
        tabBar.backgroundColor = UIColor.white
//        view.backgroundColor = .white
//        tabBar.backgroundImage = UIImage.from(color: .white)
//        tabBar.shadowImage = UIImage()

//        let tabbarBackgroundView = RoundShadowView(frame: tabBar.frame)
//        tabbarBackgroundView.cornerRadius = 10
//        tabbarBackgroundView.backgroundColor = .white
//        tabbarBackgroundView.frame = tabBar.frame
//        view.addSubview(tabbarBackgroundView)
//
        //let fillerView = UIView()
        //fillerView.frame = tabBar.frame
        tabBar.clipsToBounds = true
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //fillerView.backgroundColor = .white
        //view.addSubview(fillerView)
//
        view.bringSubviewToFront(tabBar)
        
        // Do any additional setup after loading the view.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        self.view.window?.rootViewController?.navigationController?.popToRootViewController(animated: false)
    }

    

}

