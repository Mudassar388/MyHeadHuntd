//
//  CompanyFriendsVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class CompanyFriendsVC: UIViewController {
 
    //MARK:- Variables
    fileprivate let titleArray = ["General","Membership Details", "Report a problem", "Socialize Founder", "Invite Socialize", "Join Facebook Group", "Privacy and settings", "Privacy Policy", "terms of services"]
    
    //MARK:- IBOutlets
    @IBOutlet weak var settingTableview: UITableView!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods
    
    //MARK:- IBActions
    

}

//MARK:- Tableview delegate methods
extension CompanyFriendsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .orange
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
