//
//  JobDetailsViewModel.swift
//  Rig
//
//  Created by Mac on 13/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class JobDetailsViewModel {
    typealias RIGJobDetailsClosure = (JobDetailsModel?) -> ()
    typealias RIGApplyJobClosure = (ApplyJobModel?) -> ()
    typealias ErrorMessage = (String?) -> ()

    var jobDetailsModel : JobDetailsModel?
    var jobDetailsData  : JobDetails?

    var applyJobModel : ApplyJobModel?
    var applyJobData : ApplyJobData?
      //MARK: - JobDetailsAPI  calling
      func getJobDetailsAPI(jobDetailsParams : JobDetailsParams, RIGJobDetails : @escaping RIGJobDetailsClosure, errorMessage:@escaping ErrorMessage)
      {
          let paramsDic = try? jobDetailsParams.asDictionary()
          guard let params = paramsDic else
          {
              return
          }

          APIManager.sharedInstance.getJobDetailsAPI(parameters: params, success:
                                                                  { (result) in
              let decoder = JSONDecoder()
              do
              {
                  let JobsData = try decoder.decode(JobDetailsModel.self, from: result!)
                  DispatchQueue.main.async {
                      RIGJobDetails(JobsData)
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

    //MARK: - Apply For Job api calling
    func applyToJobApi(ApplyJobParams : ApplyJobParams, RIGApplyJob : @escaping RIGApplyJobClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? ApplyJobParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.applyToJob(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let ApplyJobData = try decoder.decode(ApplyJobModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGApplyJob(ApplyJobData)
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



    // MARK: - ApplyJobModel
    struct ApplyJobModel: Codable {
        let status: Int?
        let message :String?
        let data: ApplyJobData?
        enum CodingKeys: String, CodingKey {
           case status ,message,data
        }
    }
    
    // MARK: - JobDetailsModel
    struct JobDetailsModel: Codable {
        let status: Int?
        let message :String?
        let data: JobDetails?
    }
    enum CodingKeys: String, CodingKey {
       case status ,message,data
    }

}
