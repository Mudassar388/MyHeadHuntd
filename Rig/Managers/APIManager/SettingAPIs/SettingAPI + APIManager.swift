//
//  File.swift
//  Rig
//
//  Created by Mac on 25/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire
extension APIManager
{
    func pushNotificaitonAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
        {
            settingsAPI.pushNotificaitonAPI(parameters: parameters, success: success, failure: failure)
        }
    func getpageAPi(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
        {
            settingsAPI.getpages(parameters: parameters, success: success, failure: failure)
        }

}
