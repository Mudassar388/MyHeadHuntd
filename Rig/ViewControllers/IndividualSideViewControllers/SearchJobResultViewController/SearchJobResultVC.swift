//
//  SearchJobResultVC.swift
//  Rig
//
//  Created by Ale on 12/6/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchJobResultVC: UIViewController {

    //MARK:- Variables
    var searchJobResults: [SerchJobresult]?
    
    //MARK:- IBOutlets
    @IBOutlet weak var jobResultTableview: UITableView!
    
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        registerXib()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Custom Methods
    private func registerXib(){
        jobResultTableview.register(UINib(nibName: "JobDetailCell", bundle: nil), forCellReuseIdentifier: "JobDetailCell")
    }
    
//    private func applyJob(jobId: String){
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Please wait..."
//        hud.show(in: self.view)
//        Repository.applyJob(jobId: jobId) { (status, data, message) in
//            hud.dismiss()
//            if status{
//                print("Job Applied successfully")
//            }else{
//                print("could not apply at the moment")
//            }
//        }
//    }
    
    //MARK:- IBActions
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

//MARK:- Tableview delegate methods
extension SearchJobResultVC: UITableViewDelegate, UITableViewDataSource, ApplyJobProtocol{
    func applyForJob(tag: Int) {

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchJobResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailCell", for: indexPath) as! JobDetailCell
        cell.lblCompanyName.text = searchJobResults?[indexPath.row].company_name
        cell.lblSalary.text = searchJobResults?[indexPath.row].salary
        cell.lblPosition.text = searchJobResults?[indexPath.row].position
        if searchJobResults?[indexPath.row].status == 1{
            cell.lblStatus.text = "Status: Active"
        }else{
            cell.lblStatus.text = "Status: Inactive"
        }
        cell.lblLocation.text = searchJobResults?[indexPath.row].location
        cell.lblJobType.text = searchJobResults?[indexPath.row].job_type
        cell.lblJobDescription.text = searchJobResults?[indexPath.row].job_description
        cell.btnApplyJob.tag = indexPath.row
//        cell.profileIV.sd_setImage(with: URL(string: "\(searchJobResults?[indexPath.row] ?? "")"), placeholderImage: UIImage(named: "logo"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
