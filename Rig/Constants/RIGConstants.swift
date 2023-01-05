//
//  RIGConstants.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit

struct Constants
{
    //API Request timeout
    static let RIGRequestTimeOut                             = 10
    static let RIGResponseTimeOut                            = 10

   // static let SplashScreenDelay                            = 2.0

    //API Keys

    static let APIKey                                       = "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO"
    static let ContentType                                  = "application/x-www-form-urlencoded"
    static let ContentTypeMultiPart                         = "multipart/form-data"

    //-------- Base URL --------//
    #if STAGING
    static let BaseURLV                                     = "http://techsocialserver.space/api/"
    static let BaseURLEndpoint                              = ""
    static let BaseURLImage                                 = ""
    static let AudioBaseURL                                 = ""
    #else
    static let BaseURLV                                     = ""
    static let BaseURLEndpoint                              = ""
    static let BaseURLImage                                 = ""
    static let AudioBaseURL                                 = ""
    #endif

    static var skills = [userskills]() {
        didSet {
            print("abc")
        }
    }

    static let fontLight = "Poppins-Light"

    static let AppItunesURL = ""


    static let APP_DELEGATE                                 = UIApplication.shared.delegate as! AppDelegate
    static let UIWINDOW                                     = UIApplication.shared.delegate!.window!
    static let UIConnectedScenes                                      = UIApplication.shared.connectedScenes
//    static var UIWindowScene                                = UIApplication.shared
    static let USER_DEFAULTS                                = UserDefaults.standard
    static let DEFAULTTOKEN                                 = "rig"


    //Params
    static let trueString                                   = "true"
    static let falseString                                  = "false"
    static let deviceType                                   = "ios"


    static let ScreenWidth                                  = UIScreen.main.bounds.size.width



    //lat long for Jeddah
    static let CustomLatitude                               = 21.4858
    static let CustomLongitude                              = 39.1925


}
