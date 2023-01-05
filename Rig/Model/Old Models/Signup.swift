//
//  Signup.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class Signup: Codable {
    let status: Int?
    let message: String?
    let data: UserData?

    required init(status: Int,message: String, userData: UserData) {
        self.status = status
        self.message = message
        self.data = userData
    }
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(UserData.self, forKey: .data)
    }

}

// MARK: - UserData

struct UserData : Codable {
    let id : Int?
    let user_type : Int?
    let first_name : String?
    let last_name : String?
    let profile_image : String?
    let cover_image : String?
    let email : String?
    let is_new : Bool?
    let cv_uploaded : Bool?
    let skills_exists : Bool?
    let login_token : String?
    let designation : Designation?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_type = "user_type"
        case first_name = "first_name"
        case last_name = "last_name"
        case profile_image = "profile_image"
        case cover_image = "cover_image"
        case email = "email"
        case is_new = "is_new"
        case cv_uploaded = "cv_uploaded"
        case skills_exists = "skills_exists"
        case login_token = "login_token"
        case designation = "designation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        is_new = try values.decodeIfPresent(Bool.self, forKey: .is_new)
        cv_uploaded = try values.decodeIfPresent(Bool.self, forKey: .cv_uploaded)
        skills_exists = try values.decodeIfPresent(Bool.self, forKey: .skills_exists)
        login_token = try values.decodeIfPresent(String.self, forKey: .login_token)
        designation = try values.decodeIfPresent(Designation.self, forKey: .designation)
    }

}

//struct Designation : Codable {
//    let id : Int?
//    let title : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case title = "title"
//    }
//
//    init() {
//        id = Utilities.Constants.intOValue
//        title = Utilities.Constants.blankValue
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//    }

    // Encode data
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(title, forKey: .title)
//    }
//}


