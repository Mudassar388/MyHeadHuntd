//
//  JobAPI+APIManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

extension APIManager
{
    func getJobsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.getJobsAPI(parameters: parameters, success: success, failure: failure)
    }
    func getJobDetailsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.getJobDetailAPI(parameters: parameters, success: success, failure: failure)
    }
    func getSocializerAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.getSocializer(parameters: parameters, success: success, failure: failure)
    }

    func markFavouriteJob(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.markFavouriteJob(parameters: parameters, success: success, failure: failure)
    }
    func getfavouriteJobsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.getfavouriteJobsAPI(parameters: parameters, success: success, failure: failure)
    }
    func applyToJob(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        jobAPI.applyJob(parameters: parameters, success: success, failure: failure)
    }
}
