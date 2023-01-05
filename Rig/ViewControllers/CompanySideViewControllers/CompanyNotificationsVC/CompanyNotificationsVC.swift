//
//  CompanyNotificationsVC.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit

class CompanyNotificationsVC: UIViewController {
 
    //MARK:- Variables
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var notificationTableview: UITableView!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods
    private func registerXib(){
        notificationTableview.register(UINib(nibName: "FriendRequestCell", bundle: nil), forCellReuseIdentifier: "FriendRequestCell")
    }
    
    //MARK:- IBActions
    

}

//MARK:- Tableview delegate methods
extension CompanyNotificationsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendRequestCell", for: indexPath) as! FriendRequestCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
