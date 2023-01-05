//
//  PushNotificaiton.swift
//  Rig
//
//  Created by Mac on 25/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct PushNotificationModel: Codable {
    let status: Int?
    let message: String?
   // let data: PushNotificationData?
}

// MARK: - DataClass
//struct PushNotificationData: Codable {
//    let friendRequests, notifications: []
//
//    enum CodingKeys: String, CodingKey {
//        case friendRequests = "friend_requests"
//        case notifications
//    }
//}


//// MARK: - PushNotificationModel
//struct PushNotificationModel: Codable {
//    let status, message: String?
//    let data: [PushNotificationData]?
//
//    enum CodingKeys: String, CodingKey {
//       case status,message,data
//    }
//}
//
//// MARK: - PushNotificationData
//struct PushNotificationData: Codable {
//    let id: Int?
//    let fullName, profileImage: String?
//    let requestTo: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case fullName = "full_name"
//        case profileImage = "profile_image"
//        case requestTo = "request_to"
//    }
//}
