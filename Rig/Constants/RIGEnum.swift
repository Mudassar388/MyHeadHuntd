//
//  RIGEnum.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
enum AlertViewActions: String
{
    case OK = "OK"
    case Continue = "Continue"
    case Cancel = "Cancel"
    case Back = "Back"
    case ContinueShopping = "Continue shopping"
    case GoToPayment = "Go to pay"
    case Yes = "Yes"
    case No = "No"
    case TrackAppointment = "Track the status of your appointment confirmation here"
    case UpdateApp = "Update App"

    case Camera = "Take a Photo"
    case Gallery = "Select from Gallery"

    case GoogleMaps = "Google Maps"
    case AppleMaps = "Apple Maps"
}

enum APIStatus:Int
{
    case Success = 200
    case Error   = 400
//    case InternalServerError = "500"
//    case Failed = "failed"
}
enum UserType: Int
{
    case Company = 2
    case User    = 3
}
enum APIKEYS: String {
    case data
    case response
    case success
    case user
    case token
    case message
}
enum TabBarItems:Int
{
    case Home = 0
    case Messages = 1
    case Socialize = 2
    case Vacancies = 3
    case Notifications = 4
}
enum TabBarItemsCompany:Int
{
    case Home = 0
    case Messages = 1
    case Socialize = 2
    case Notifications = 3
}
enum PageTitle:String{
    case AboutUS = "About US"
    case TermsAndConditions = "Terms and Conditions"
    case PrivacyPolicy = "Privacy Policy"
}
