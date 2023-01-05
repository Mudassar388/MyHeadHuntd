//
//  FavirouteJobsViewController.swift
//  Rig
//
//  Created by Mac on 27/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import SideMenu
class FavouriteJobsViewController: UIViewController, jobFeedDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var jobFeedsTableView: UITableView!
    @IBOutlet weak var userImageButton: UIButton!
    var favouriteJobsViewModel = FavouriteJobsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXIB()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getJobFeedsAPI()
    }
    func registerXIB() {
        jobFeedsTableView.delegate = self
        jobFeedsTableView.dataSource = self
        jobFeedsTableView.register(UINib(nibName: XIBViews.JobFeedsTableViewCell, bundle: nil), forCellReuseIdentifier:XIBViews.JobFeedsTableViewCell)
    }
    
    @IBAction func imageBtnTapped(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


    //MARK: - API CALLING
    func getJobFeedsAPI(){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            
            favouriteJobsViewModel.getFavJobs(jobId: 3) { feeds in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.tabBarController)
                self.favouriteJobsViewModel.jobFeeds = (feeds)
                self.jobFeedsTableView.reloadData()
            }
        }
    }
    func applyForJobTapped(jobID: Int?) {
        RIG.NavigationManager.navigateToJobDetailsViewController(jobID: jobID ?? 0, viewController: self)
    }
}
extension FavouriteJobsViewController: UITableViewDelegate, UITableViewDataSource{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteJobsViewModel.jobFeeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "JobFeedsTableViewCell") as! JobFeedsTableViewCell
            let model = JobFeedsTableViewCellModel.init(jobFeeds: favouriteJobsViewModel.jobFeeds[indexPath.row], viewController: self )
            cell.JobFeedsTableViewCellModel = model
            cell.delegate = self
            return cell


    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let JobID =  favouriteJobsViewModel.jobFeeds[indexPath.row].id {
            RIG.NavigationManager.navigateToJobDetailsViewController(jobID:JobID, viewController: self)
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let height: CGFloat = 110
        return height
    }



}
