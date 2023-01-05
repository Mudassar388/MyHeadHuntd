//
//  ServiceVC.swift
//  Rig
//
//  Created by Ale on 12/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class ServiceVC: UIViewController {

    var servicesArray = ["Tech Energy","Tech Location","Website","TourNote","Crew Calendar"]
    
    var imagesArray = [UIImage(named: "profile")!,UIImage(named: "profile")!,UIImage(named: "profile")!,UIImage(named: "profile")!,UIImage(named: "profile")!]
    
    @IBOutlet weak var serviceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        // Do any additional setup after loading the view.
    }
     
    func registerXib(){
        self.serviceTableView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    } 
}

extension ServiceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.serviceIV.image = imagesArray[indexPath.row]
        cell.serviceLbl.text = servicesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
