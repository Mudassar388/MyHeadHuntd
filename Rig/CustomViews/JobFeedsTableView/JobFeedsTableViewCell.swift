//
//  JobFeedsTableViewCell.swift
//  Rig
//
//  Created by STC Macbook Pro on 03/04/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
protocol jobFeedDelegate{
    func applyForJobTapped(jobID:Int?)
}

class JobFeedsTableViewCell: UITableViewCell {
    var delegate : jobFeedDelegate?

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var addFavBtn: UIButton!
    @IBOutlet weak var addFavImage: UIImageView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    var homeViewModel = HomeViewModel()
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var applyButton: UIButton!

    var JobFeedsTableViewCellModel : JobFeedsTableViewCellModel!
    {
        didSet
        {
            self.populateData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyButton.clipsToBounds = true
        applyButton.layer.cornerRadius = 10
        applyButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width:0.0, height:3.0);
        bgView.layer.shadowOpacity = 0.20;
        bgView.layer.masksToBounds = false;
        bottomView.cornerRadius = 10
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func fevTapped(_ sender:UIButton){
        markFavAPI(JobID: JobFeedsTableViewCellModel.jobFeeds?.id ?? 0)
    }
    @IBAction func applyTapped(_ sender:UIButton){
        delegate?.applyForJobTapped(jobID: JobFeedsTableViewCellModel.jobFeeds?.id ?? 0)
    }
    func populateData()
    {
        jobTitleLabel.text = JobFeedsTableViewCellModel.jobFeeds?.title ?? ""
        jobDescriptionLabel.text = JobFeedsTableViewCellModel.jobFeeds?.description ?? ""
        salaryLabel.text = "\(JobFeedsTableViewCellModel.jobFeeds?.min_salary ?? 0)k - \(JobFeedsTableViewCellModel.jobFeeds?.max_salary ?? 0)k"
        experienceLabel.text = "\(JobFeedsTableViewCellModel.jobFeeds?.min_experience ?? "") + Years"
        
        postDateLabel.text = RIG.DataManager.dateFromString(timeString:  JobFeedsTableViewCellModel.jobFeeds?.posted_at ?? "", withFormatIN: "yyyy-MM-dd'T'HH:mm:ss", andFormatOut: "MMM d, yyyy")

        if JobFeedsTableViewCellModel.jobFeeds?.total_matched_skills == 1 || JobFeedsTableViewCellModel.jobFeeds?.total_matched_skills == 0 {
            matchLabel.text = "\(JobFeedsTableViewCellModel.jobFeeds?.total_matched_skills ?? 0) Skill Matched"
        }else{
            matchLabel.text = "\(JobFeedsTableViewCellModel.jobFeeds?.total_matched_skills ?? 0) Skills Matched"
        }
        if JobFeedsTableViewCellModel.jobFeeds?.is_favourite ?? false {
            addFavImage.image = RIGImages.FevoriteJobImage
        }else{
            addFavImage.image = RIGImages.NonFevoriteJobImage
        }

        if JobFeedsTableViewCellModel.jobFeeds?.is_applied ?? false {
            applyButton.setTitle("Applied", for: .normal)
            applyButton.isUserInteractionEnabled =  false
        }

    }
    
    func markFavAPI(JobID:Int?){
        if RIG.NetworkManager.isNetworkReachable(viewController: self.JobFeedsTableViewCellModel.viewController)
        {
            RIG.UIManager.showCustomActivityIndicator(controller: self.JobFeedsTableViewCellModel.viewController?.tabBarController, withMessage: "")
            var params  = MarkFavouriteParams()
            params.jobID = JobID
            homeViewModel.markFavouriteAPI(MarkFavouriteParams: params) { (FavJob) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self.JobFeedsTableViewCellModel.viewController?.tabBarController)
                if FavJob?.status == APIStatus.Success.rawValue
                {
                    self.homeViewModel.markfavouriteData = FavJob?.data
                    if self.homeViewModel.markfavouriteData?.isFavourite == true{
                        self.addFavImage.image = RIGImages.FevoriteJobImage
                    }else{
                        self.addFavImage.image = RIGImages.NonFevoriteJobImage
                    }
                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:FavJob?.message, okButton: true, viewController: self.JobFeedsTableViewCellModel.viewController! ) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller:self.JobFeedsTableViewCellModel.viewController?.tabBarController)
                print (message ?? "")

                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self.JobFeedsTableViewCellModel.viewController!) { _ in }
            }

        }
    }
}
