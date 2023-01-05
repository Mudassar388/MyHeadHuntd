//
//  ProfileAPIs.swift
//  Rig
//
//  Created by Mac on 14/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class ProfileAPIs: APIManagerBase
{
    func getAppliedJobs(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.appliedJobs.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func getProfileVAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.viewProfile.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func sendFriendRequestAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.sendFriendRequest.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)

    }
    func toggleFriendRequestAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.toggleFriendRequest.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)

    }


}
