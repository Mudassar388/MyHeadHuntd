//
//  ComppanyAPIs.swift
//  Rig
//
//  Created by Mac on 20/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class ComppanyAPIs: APIManagerBase
{
    func postJobAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.jobCreate.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
}
