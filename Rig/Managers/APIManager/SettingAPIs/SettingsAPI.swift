//
//  SettingsAPI.swift
//  Rig
//
//  Created by Mac on 25/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class SettingsAPI: APIManagerBase
{
    func pushNotificaitonAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.pushNotification.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func getpages(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.page.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }

}
