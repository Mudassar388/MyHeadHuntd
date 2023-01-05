//
//  RIGAlerts.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
struct RIGAlerts
{
    static let Error = "Error"

    //Network Errors
    static let ReachabilityErrorTitle       =   ""
    static let ReachabilityErrorMessage    =   "Your network is in Airplane mode. Please enable the network"
    static let SlowInternetError           =   "Your internet speed is slow"
    static let SomethingWentWrong           =   "Something went wrong"
    static let RIG           =   "Headhuntd"



    //Alamofire Error Messages
        static let requestTimedout           = "Loading failed please check your internet connection."
        static let serverHostnameNotFound    = "URLSessionTask failed with error: A server with the specified hostname could not be found."
        static let internetConnectionOffline = "URLSessionTask failed with error: The Internet connection appears to be offline."
        static let networkConnectionLost     = "URLSessionTask failed with error: The network connection was lost."
}
