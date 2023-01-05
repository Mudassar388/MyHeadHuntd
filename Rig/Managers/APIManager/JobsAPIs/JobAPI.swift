//
//  HomeViewModel.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class JobAPI: APIManagerBase
{
    func getJobsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.jobsFeed.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func getfavouriteJobsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.favouriteJobs.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }

    func getJobDetailAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.jobDetail.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func getSocializer(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.recentSocializers.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func markFavouriteJob(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let param = [TGValues.JobID : parameters[TGValues.JobID] ?? 0  ] as [String : Any]
        let apiURL: URL = URLforRoute(route: APIURLs.markFavourite.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL, parameters: param, success: success, failure: failure)
    }
    func applyJob(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let param = [TGValues.JobID: parameters[TGValues.JobID] ?? 0  ] as [String : Any]
        let apiURL: URL = URLforRoute(route: APIURLs.applyJob.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL, parameters: param, success: success, failure: failure)
    }




//        let param = [
//            "lang": TG.DataManager.appLanguage?.rawValue ?? ""
//        ] as [String : Any]
//        let offerId = "\(parameters[TGValues.OfferId] ?? 0)"
//        let url = String(format: "%@%@%@", APIURLs.offersAPI.defaultUrlV(), offerId, APIURLs.likeOfferAPI.rawValue)
//        let apiURL: URL = URLforRoute(route: url)! as URL
//        self.postRequestWithUserToken(route: apiURL, parameters: param, success: success, failure: failure)

}
