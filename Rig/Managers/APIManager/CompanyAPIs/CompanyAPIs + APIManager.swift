//
//  CompanyAPIs + APIManager.swift
//  Rig
//
//  Created by Mac on 20/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire
extension APIManager
{
    func postJobAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        
        companyAPIs.postJobAPI(parameters: parameters, success: success, failure: failure)
    }
}
