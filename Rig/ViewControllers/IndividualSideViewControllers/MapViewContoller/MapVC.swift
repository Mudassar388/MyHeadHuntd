//
//  MapVC.swift
//  Rig
//
//  Created by Ale on 12/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
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
