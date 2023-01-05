//
//  ProfileAPI + APIManager.swift
//  Rig
//
//  Created by Mac on 14/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire
extension APIManager
{
    func getAppliedJobsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        profileAPI.getAppliedJobs(parameters: parameters, success: success, failure: failure)
    }
    func getProfileVAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        profileAPI.getProfileVAPI(parameters: parameters, success: success, failure: failure)
    }
    func sendFriendRequestAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        profileAPI.sendFriendRequestAPI(parameters: parameters, success: success, failure: failure)
    }
    func toggleFriendRequestAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        profileAPI.toggleFriendRequestAPI(parameters: parameters, success: success, failure: failure)
    }

}
