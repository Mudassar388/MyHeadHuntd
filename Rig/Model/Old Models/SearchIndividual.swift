//
//  SearchIndividual.swift
//  Rig
//
//  Created by Ale on 11/5/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class SearchIndividual : Codable {
    let status : String?
    let message : String?
    let serchresult : [Serchresult]?

    enum CodingKeys: String, CodingKey {

        case status = "Status"
        case message = "message"
        case serchresult = "serchresult"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        serchresult = try values.decodeIfPresent([Serchresult].self, forKey: .serchresult)
    }
}

class Serchresult : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let email_verified_at : String?
    let password : String?
    let country : String?
    let designation : String?
    let filesource : String?
    let remember_token : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case email_verified_at = "email_verified_at"
        case password = "password"
        case country = "country"
        case designation = "designation"
        case filesource = "filesource"
        case remember_token = "remember_token"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        filesource = try values.decodeIfPresent(String.self, forKey: .filesource)
        remember_token = try values.decodeIfPresent(String.self, forKey: .remember_token)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
