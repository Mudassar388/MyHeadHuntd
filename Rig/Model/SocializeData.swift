//
//  SocializeData.swift
//  Rig
//
//  Created by Mac on 10/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - SocializeData
struct SocializeData: Codable {
      let id: Int?
      let firstName, lastName: String?
      let profileImage: String?
      let coverImage: String?
      let designation: Designation?
      let isRequestSent, isRequestReceived, isFriend, isPremium: Bool?

      enum CodingKeys: String, CodingKey {
          case id
          case firstName = "first_name"
          case lastName = "last_name"
          case profileImage = "profile_image"
          case coverImage = "cover_image"
          case designation
          case isRequestSent = "is_request_sent"
          case isRequestReceived = "is_request_received"
          case isFriend = "is_friend"
          case isPremium = "is_premium"
      }
  }

