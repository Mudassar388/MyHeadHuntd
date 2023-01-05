//
//  FavouriteJobsViewModel.swift
//  Rig
//
//  Created by Mac on 27/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class FavouriteJobsViewModel{

    typealias RIGJobFeedClosure = (JobFeedModel?) -> ()
    typealias RIGFeedClosure = ([Feeds]?) -> ()
    typealias ErrorMessage = (String?) -> ()

    var jobFeedModel : JobFeedModel?
//    var jobFeeds : [JobFeedData] = []
    var jobFeeds : [Feeds] = []
    var jobFeed: Feeds?
    
   
    //MARK: - getJobFeeds api calling
    func getfavouriteJobFeeds(FavouriteJobsParams : FavouriteJobsParams, RIGJobFeeds : @escaping RIGJobFeedClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? FavouriteJobsParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.getfavouriteJobsAPI(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let JobsData = try decoder.decode(JobFeedModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGJobFeeds(JobsData)
                }
            }
            catch let error
            {
                print(error)
                DispatchQueue.main.async {
                    errorMessage(error.localizedDescription)
                }
            }
        }) { (error:NSError) in
            DispatchQueue.main.async {
                errorMessage(error.localizedDescription)
        }

    }
    }
    
    
    func getFavJobs (jobId: Int, completion: @escaping ([Feeds]) -> Void) {
        HTTPManager.shared.get("favourite/jobs?job_id=\(jobId)") { (response: GenericModel<Feeds>?) in
            guard let resp = response else {return}

            if resp.status == 200 {
                DispatchQueue.main.async {
                    self.jobFeeds = resp.data ?? []
                    completion(self.jobFeeds)
                }
            } else {
                print("something went wrong")
            }

        }
    }

}
    // MARK: - JobFeedModel
    struct JobFeedModel: Codable {

        let status: Int?
        let message : String?
//        let data: [JobFeedData]?
        let data: JobFeedData?

        enum CodingKeys: String, CodingKey {
           case status,message,data
        }
    }

