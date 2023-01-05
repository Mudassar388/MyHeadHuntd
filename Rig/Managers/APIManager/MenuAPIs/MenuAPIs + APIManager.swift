//
//  MenuAPIs + APIManager.swift
//  Rig
//
//  Created by Mac on 21/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

extension APIManager
{
    func getAboutPage(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        menuAPIs.getAboutAPI(parameters: parameters, success: success, failure: failure)
    }
}
