//
//  APIManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//


import UIKit

typealias DefaultAPIFailureClosure = (NSError) -> Void
typealias DefaultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias DefaultBoolResultAPISuccesClosure = (Bool) -> Void
typealias DefaultArrayResultAPISuccessClosure = (Dictionary<String,AnyObject>) -> Void
typealias APISuccessClosureWithStatusCode = (Dictionary<String,AnyObject>, _ StatusCode:Int) -> Void
typealias ResultAPISuccessClosure = (Data?) -> Void


protocol APIErrorHandler
{
    func handleErrorFromResponse(response: Dictionary<String,AnyObject>)
    func handleErrorFromError(error:NSError)
}

class APIManager: NSObject
{
    static let sharedInstance = APIManager()

//
//    var serverToken: String? {
//        get{
//            return ""
//        }
//    }


      let jobAPI = JobAPI()
      let profileAPI = ProfileAPIs()
      let registrationAPIs = RegistrationAPIs()
      let companyAPIs    = ComppanyAPIs()
      let menuAPIs = MenuAPIs()
      let settingsAPI = SettingsAPI()
//    let clinicsAPI = ClinicsAPI()
//    let paymentAPI = PaymentAPI()
//    let chatAPI = ChatAPI()
//    let nearestDoctorsAPI = NearestDoctorsAPI()

}
