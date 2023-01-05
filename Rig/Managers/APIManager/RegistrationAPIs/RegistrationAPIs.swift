//
//  SignUpAPIs.swift
//  Rig
//
//  Created by Mac on 16/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class RegistrationAPIs: APIManagerBase
{
    func SignUpAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.signup.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func LoginAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.login.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func saveUserSkillsAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.saveUserSkills.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func ForgetPasswordAPI(parameters: Parameters, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.ForgotPassword.defaultUrl())! as URL
        self.postRequestWithUserTokenwithParams(route: apiURL,parameters: parameters, success: success, failure: failure)
    }
    func postPDFUpload(parameters: Parameters,dataDOC:Data,myfile:String, success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.uploadDoc.defaultUrl())! as URL
        self.postRequestMultiPartPDFUpload(route: apiURL,DocData: dataDOC,fileName: myfile,parameters: parameters, success: success, failure: failure)
    }

    func getSkillIndustry(parameters: Parameters,success:@escaping ResultAPISuccessClosure, failure:@escaping DefaultAPIFailureClosure)
    {
        let apiURL: URL = URLforRoute(route: APIURLs.skillIndustry.defaultUrl())! as URL
        self.getRequestWithUserTokenwithParams(route: apiURL, parameters: parameters, success: success, failure: failure)

    }

}
