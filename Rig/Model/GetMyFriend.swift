//
//  GetMyFriend.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-07-02.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation


struct GetMyFriend : Codable {
    let total_friends : Int?
    let friends : [Friends]?

    enum CodingKeys: String, CodingKey {

        case total_friends = "total_friends"
        case friends = "friends"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total_friends = try values.decodeIfPresent(Int.self, forKey: .total_friends)
        friends = try values.decodeIfPresent([Friends].self, forKey: .friends)
    }

}


struct Friends : Codable {
    let id : Int?
    let load_id : Int?
    let first_name : String?
    let last_name : String?
    let profile_image : String?
    let created_at : String?
    let designation : FriendDesignation?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case load_id = "load_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case profile_image = "profile_image"
        case created_at = "created_at"
        case designation = "designation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        load_id = try values.decodeIfPresent(Int.self, forKey: .load_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        designation = try values.decodeIfPresent(FriendDesignation.self, forKey: .designation)
    }

}

struct FriendDesignation : Codable {
    let id : Int?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
