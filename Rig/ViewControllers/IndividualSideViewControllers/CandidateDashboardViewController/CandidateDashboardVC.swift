//
//  CandidateDashboardVC.swift
//  Rig
//
//  Created by Ale on 9/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD

class CandidateDashboardVC: UIViewController {

    
    //MARK:- Variables
    var searchResults: SearchIndividual?
    
    //MARK:- IBOutlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
    @IBOutlet weak var positionTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var lblShortListCandidateCount: UILabel!
    
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popUpView.removeFromSuperview()
    }
    
    //MARK:- Custom Methods
    
    fileprivate func setLayout(){
        if let cName = AppSingleton.shared.currentCompany?.data?.company?.company_name{
            nameLbl.text = cName
        }
        
//        if let uName = AppSingleton.shared.currentUser?.data?.firstName{
//            nameLbl.text = uName
//        }
    }

    func searchCandidate(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Searching..."
        hud.show(in: self.view)
//        Repository.searchCandidate(position: positionTF.text ?? "", location: locationTF.text ?? "") { (status, data, message) in
//            hud.dismiss()
//            if status{
//                self.searchResults = data
//                self.resultTableView.reloadData()
//                if self.searchResults?.serchresult?.count ?? 0 > 0{
//                    self.popUpView.frame = self.view.frame
//                    self.view.addSubview(self.popUpView)
//                }
//            }else{
//                print("Error")
//            }
//        }
    }
    
    //MARK:- IBActions
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSearch(_ sender: UIButton) {
        searchCandidate()
        
    }
    @IBAction func btnActionShortListedCandidates(_ sender: UIButton) {
        if (self.searchResults?.serchresult?.count ?? 0) > 0{
            let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "SearchJobResultVC") as! SearchJobResultVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CandidateDashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults?.serchresult?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        cell.nameLbl.text = (self.searchResults?.serchresult?[indexPath.row].first_name ?? "") + " ," + (self.searchResults?.serchresult?[indexPath.row].last_name ?? "")
        cell.emailLbl.text = (self.searchResults?.serchresult?[indexPath.row].email ?? "")
        cell.designationLbl.text = (self.searchResults?.serchresult?[indexPath.row].designation ?? "") + " ," + (self.searchResults?.serchresult?[indexPath.row].country ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}

class SearchResultCell: UITableViewCell{
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var designationLbl: UILabel!
}
