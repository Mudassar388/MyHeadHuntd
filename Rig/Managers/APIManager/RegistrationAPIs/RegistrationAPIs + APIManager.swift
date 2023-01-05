//
//  SignUpAPIs + APIManager.swift
//  Rig
//
//  Created by Mac on 16/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire
extension APIManager
{
    func SignUpAPICall(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.SignUpAPI(parameters: parameters, success: success, failure: failure)
    }
    func LoginAPICall(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.LoginAPI(parameters: parameters, success: success, failure: failure)
    }
    func saveUserSkillsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.saveUserSkillsAPI(parameters: parameters, success: success, failure: failure)
    }
    func forgetpasswordAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.ForgetPasswordAPI(parameters: parameters, success: success, failure: failure)
    }
    func postPDFUploadingAPI(parameters: Parameters,Docdata:Data,filename:String, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.postPDFUpload(parameters: parameters,dataDOC: Docdata,myfile: filename, success: success, failure: failure)
    }
    func getSkillIndustryApi(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        registrationAPIs.getSkillIndustry(parameters: parameters, success: success, failure: failure)
    }


}
