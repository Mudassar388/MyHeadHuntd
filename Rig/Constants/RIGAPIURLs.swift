//
//  RIGAPIURLs.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

enum APIURLs: String
{

    //MARK: -  APIs ENDPOINTS

    case login = "login"
    case signup = "signup"
    case ForgotPassword = "forgot/password"
    case jobsFeed = "jobs/feed"
    case uploadImage = "upload/image"
    case viewProfile = "view/profile"
    case editProfile = "edit/profile"
    case favouriteJobs = "favourite/jobs"
    case jobDetail = "job/detail"
    case applyJob = "apply/job"
    case markFavourite = "mark/favourite"
    case uploadDoc = "upload/doc"
    case recentSocializers = "recent/socializers"
    case saveUserSkills = "save/user/skills"
    case companyPostedJobs = "company/posted/jobs"
    case appliedJobs = "applied/jobs"
    case jobApplicants = "job/applicants"
    case toggleShortlist = "toggle/shortlist"
    case sendFriendRequest = "send/friend-request"
    case toggleFriendRequest = "toggle/friend-request"
    case recievedFriendRequest = "received/friend-requests"
    case removeFriend = "remove/friend"
    case pushNotification = "push/notification"
    case addFellow = "add/fellow"
    case jobCreate = "job/create"
    case addReference = "add/reference"
    case premium = "premium"
    case citiesAPI = "cities.json"
    case verifyReferece = "verify/referece"
    case page = "page"
    case skillIndustry = "skill/industry"
    case storeMessages = "chat/storeMessage"
    case inboxChat = "chat/getSingleChat"
    case userChat = "chat/getChat"
    case friends = "my/friends"
    case refreshTime = "refresh_time"
    case saveRefferal = "save/refferal"
    case sendPushTest = "send/test/push"
    case saveDeviceToken = "save/device/token"
    case userskill = "user/skills"
   
    //Company Endpoints
    case ViewPage = "view-page"



       //MARK:- Get URL Methods

       func defaultUrl() -> String
       {
           let configurationmanager : ConfigurationManager = ConfigurationManager()
           return configurationmanager.getBaseURL().absoluteString + self.rawValue
       }

       func defaultUrlV() -> String
       {
           let configurationmanager : ConfigurationManager = ConfigurationManager()
           return configurationmanager.getBaseURLV().absoluteString + self.rawValue
       }
       func defaultUrlVOffers() -> String
          {
              let configurationmanager : ConfigurationManager = ConfigurationManager()
              return configurationmanager.getBaseURLVOffers().absoluteString + self.rawValue
          }
      func defaultUrlEndpoint() -> String
         {
             let configurationmanager : ConfigurationManager = ConfigurationManager()
             return configurationmanager.getBaseURLEndpoint().absoluteString + self.rawValue
         }

       func defaultUrlEndpoint2() -> String {
           let configurationmanager : ConfigurationManager = ConfigurationManager()
           return configurationmanager.getBaseURLEndpoint2().absoluteString + self.rawValue
       }

       func defaultUrlEndpointPartner() -> String
          {
              let configurationmanager : ConfigurationManager = ConfigurationManager()
              return configurationmanager.getBaseURLEndpointPartner().absoluteString + self.rawValue
          }


       func defaultUrlAuthEndpoint() -> String
          {
              let configurationmanager : ConfigurationManager = ConfigurationManager()
              return configurationmanager.getBaseURLAuthEndpoint().absoluteString + self.rawValue
          }


}


