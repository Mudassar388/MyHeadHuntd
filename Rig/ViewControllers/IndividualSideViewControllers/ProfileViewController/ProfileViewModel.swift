//
//  ProfileViewModel.swift
//  Rig
//
//  Created by Mac on 14/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class  ProfileViewModel{

    typealias RIGAppliedJobsClosure = (AppliedJobsModel?) -> ()
    typealias RIGProfileVModelClosure = (ProfileVModel?) -> ()
    typealias RIGSentFriendRequestClosure = (FriendRequestModel?) -> ()
    typealias RIGToggleFriendRequestClosure = (FriendRequestModel?) -> ()

    typealias ErrorMessage = (String?) -> ()

    var appliedJobsModel : AppliedJobsModel?
  //var appliedJob : [JobFeedData] = []
    var appliedJob : [Feeds] = []
    var profileVModel : ProfileVModel?
    var profileV: ProfileV?
    var sentFriendRequest : FriendRequestModel?
    var toggleFriendRequest : FriendRequestModel?


    //MARK: - getJobFeeds api calling
    func toggleFriendRequestAPI(toggleFriendRequestParams : ToggleFriendRequestParams, RIGToggleFriendRequestClosure : @escaping RIGToggleFriendRequestClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? toggleFriendRequestParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.toggleFriendRequestAPI(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let Response = try decoder.decode(FriendRequestModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGToggleFriendRequestClosure(Response)
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
    //MARK: - getJobFeeds api calling
    func sendFriendRequestAPI(sentFriendRequestParams : SentFriendRequestParams, RIGSentFriendRequestClosure : @escaping RIGSentFriendRequestClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? sentFriendRequestParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.sendFriendRequestAPI(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let Response = try decoder.decode(FriendRequestModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGSentFriendRequestClosure(Response)
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


    //MARK: - getJobFeeds api calling
    func getProfileVAPI(profileVParams : ProfileVParams, RIGProfileVModel : @escaping RIGProfileVModelClosure, errorMessage:@escaping ErrorMessage) //working
    {
        let paramsDic = try? profileVParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.getProfileVAPI(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let ProfileData = try decoder.decode(ProfileVModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGProfileVModel(ProfileData)
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

      //MARK: - getJobFeeds api calling
      func getAppliedJobsAPI(appliedJobsParams : AppliedJobsParams, RIGAppliedJobs : @escaping RIGAppliedJobsClosure, errorMessage:@escaping ErrorMessage)
      {
          let paramsDic = try? appliedJobsParams.asDictionary()
          guard let params = paramsDic else
          {
              return
          }

          APIManager.sharedInstance.getAppliedJobsAPI(parameters: params, success:
                                                                  { (result) in
              let decoder = JSONDecoder()
              do
              {
                  let JobData = try decoder.decode(AppliedJobsModel.self, from: result!)
                  DispatchQueue.main.async {
                      RIGAppliedJobs(JobData)
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





    // MARK: - ProfileVModel
    struct ProfileVModel: Codable {
        let status: Int?
        let message:String?
        let data: ProfileV?
        enum CodingKeys : String,CodingKey{
            case status, message ,data
        }
    }
    
    // MARK: - Welcome
    struct AppliedJobsModel: Codable {
        let status: Int?
        let message :String?
//        let data: [JobFeedData]?
        let data: JobFeedData?
        enum CodingKeys: String, CodingKey{
            case status,message,data
        }
    }
    // MARK: - FriendRequestModel
    struct FriendRequestModel: Codable {
        let status: Int?
        let message: String?
        enum CodingKeys:String,CodingKey{
          case status,message
        }
    }


}
