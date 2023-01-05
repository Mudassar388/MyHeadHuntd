//
//  NetworkingVC.swift
//  Rig
//
//  Created by Ale on 9/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

protocol ModalDelegate {
func changeValue(value: String)
}

import UIKit
import JGProgressHUD

class NetworkingVC: UIViewController, UIAdaptivePresentationControllerDelegate, ModalDelegate {

    var searchResults: SearchIndividual?
    var conformString : String = ""
    @IBOutlet weak var jobSearchTF: UITextField!
    @IBOutlet weak var vacanciesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        registerXib()
// ccommented for testing
//        searchCandidate()
        jobSearchTF.attributedPlaceholder = NSAttributedString(string: "Search Jobs",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)])
        // Do any additional setup after loading the view.
    }
     
    override func viewDidAppear(_ animated: Bool) {
    }
//    @IBAction func btnActionSearchCandidate(_ sender: UIButton) {
//        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CandidateDashboardVC")
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    private func registerXib(){
           vacanciesTableView.register(UINib(nibName: "VacanciesCell", bundle: nil), forCellReuseIdentifier: "VacanciesCell")
       }
    
    @IBAction func btnActionSearchJob(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "CandidateDashboardVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    @IBAction func filterJobsAction(_ sender: UIButton) {
        let jobFilterVC = self.storyboard?.instantiateViewController(withIdentifier: "JobFilterVC") as! JobFilterVC
        //jobFilterVC.modalPresentationStyle = .fullScreen
        jobFilterVC.delegate = self
        self.tabBarController?.present(jobFilterVC, animated: true)
    }
    
    func changeValue(value: String) {
        conformString = value
        print("confirm string: " + conformString)
    }
    
    func searchCandidate(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Searching..."
        hud.show(in: self.view)
//        Repository.searchCandidate(position: "", location: "") { (status, data, message) in
//            hud.dismiss()
//            if status{
//                self.searchResults = data
//                //self.resultTableView.reloadData()
////                if self.searchResults?.serchresult?.count ?? 0 > 0{
////                    self.popUpView.frame = self.view.frame
////                    self.view.addSubview(self.popUpView)
////                }
//            }else{
//                print("Error")
//            }
//        }
    }
    
}

//MARK:- Tableview delegate methods
//RequestReponseProtocol
extension NetworkingVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return searchResults?.data?.request?.count ?? 0
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VacanciesCell", for: indexPath) as! VacanciesCell
        cell.jobTitleLabel.text = "iOS Developer"//allNotifications?.data?.request?[indexPath.row].full_name
        cell.companyNameLabel.text = "securetech & consultancy pvt ltd"
        cell.jobLocationLabel.text = "Islamabad, Full Time"
        cell.experienceLabel.text = "4 - 5 Years"
        cell.vacancyIV.sd_setImage(with: URL(string: "\("https://www.google.com/imgres?imgurl=https://www.usmlive.com/wp-content/uploads/2019/04/logo.png&imgrefurl=https://www.usmlive.com/biometric-services/secure-tech/&tbnid=rJaZaokQZETZqM&vet=1&docid=LmuoGRW3-41pSM&w=306&h=65&source=sh/x/im")"), placeholderImage: UIImage(named: "logo"))
        //cell.requestResponseDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
}
