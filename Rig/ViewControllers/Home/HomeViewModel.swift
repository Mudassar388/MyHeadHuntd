//
//  HomeViewModel.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

//enum JobType: Int {
//    case FullTime = 1
//    case PartTime
//    case Internship
//    case Temporary
//}

class HomeViewModel
{
    typealias RIGJobFeedClosure = (JobFeedModel?) -> ()
    typealias RIGmarkFavouriteClosure = (MarkFavouriteModel?) -> ()
  
    typealias ErrorMessage = (String?) -> ()

    var jobFeedModel : JobFeedModel?
    var jobFeeds : [Feeds] = []

    var markFavouriteModel : MarkFavouriteModel?
    var markfavouriteData : MarkfavouriteData?

  


  
    //MARK: - getJobFeeds api calling
    func getJobFeeds(jobFeedParams : JobFeedParams, RIGJobFeeds : @escaping RIGJobFeedClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? jobFeedParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.getJobsAPI(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let JobsData = try decoder.decode(JobFeedModel.self, from: result!)
                DispatchQueue.main.async {
                    self.jobFeedModel = JobsData
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
    //MARK: - Mark Favourite api calling
    func markFavouriteAPI(MarkFavouriteParams : MarkFavouriteParams, RIGmarkFavourite : @escaping RIGmarkFavouriteClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? MarkFavouriteParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.markFavouriteJob(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let markFavourite = try decoder.decode(MarkFavouriteModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGmarkFavourite(markFavourite)
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

    

    

    // MARK: - JobFeedModel
    struct JobFeedModel: Codable {
        
        let status: Int?
        let message : String?
        let data: JobFeedData?
        
        enum CodingKeys: String, CodingKey {
            case status,message,data
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            data = try values.decodeIfPresent(JobFeedData.self, forKey: .data)
            message = try values.decodeIfPresent(String.self, forKey: .message)
            status = try values.decodeIfPresent(Int.self, forKey: .status)
        }
        
    }

    // MARK: - favouriteModel
    struct MarkFavouriteModel: Codable {
        let status: Int?
        let message :String?
        let data: MarkfavouriteData?
        enum CodingKeys: String, CodingKey {
           case status ,message,data
        }

    }


   




}
