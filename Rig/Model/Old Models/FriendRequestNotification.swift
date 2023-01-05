//
//  FriendRequestNotification.swift
//  Rig
//
//  Created by Ale on 12/6/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class FriendRequestNotification : Codable {
    let status : String?
    let message : String?
    let data : FriendRequestData?

    enum CodingKeys: String, CodingKey {

        case status = "Status"
        case message = "message"
        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(FriendRequestData.self, forKey: .data)
    }

}

class FriendRequestData : Codable {
    let total : Int?
    let request : [Request]?

    enum CodingKeys: String, CodingKey {

        case total = "Total"
        case request = "Request"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        request = try values.decodeIfPresent([Request].self, forKey: .request)
    }

}

class Request : Codable {
    let friend_ID : Int?
    let full_name : String?
    let friendimage : String?

    enum CodingKeys: String, CodingKey {

        case friend_ID = "friend_ID"
        case full_name = "full_name"
        case friendimage = "friendimage"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        friend_ID = try values.decodeIfPresent(Int.self, forKey: .friend_ID)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        friendimage = try values.decodeIfPresent(String.self, forKey: .friendimage)
    }

}

