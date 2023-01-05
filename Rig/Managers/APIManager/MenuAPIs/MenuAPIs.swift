//
//  MenuAPIs.swift
//  Rig
//
//  Created by Mac on 21/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class MenuAPIs: APIManagerBase
{
    func getAboutAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.ViewPage.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }


}
