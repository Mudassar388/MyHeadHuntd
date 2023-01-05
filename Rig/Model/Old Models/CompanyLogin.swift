//
//  CompanyLogin.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class CompanyLogin : Codable {
    let status : String?
    let message : String?
    let data : CData?

    enum CodingKeys: String, CodingKey { 
        case status = "Status"
        case message = "message"
        case data = "data"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(CData.self, forKey: .data)
    }

}

class CData : Codable {
    let api_token : String?
    let company : CurrentCompanyDetail?

    enum CodingKeys: String, CodingKey {

        case api_token = "api_token"
        case company = "company"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_token = try values.decodeIfPresent(String.self, forKey: .api_token)
        company = try values.decodeIfPresent(CurrentCompanyDetail.self, forKey: .company)
    }

}

class CurrentCompanyDetail : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let company_name : String?
    let filesource : String?
    let company_website : String?
    let service : String?
    let company_size : String?
    let short_description_of_service : String?
    let contact_person : String?
    let street_address : String?
    let city : String?
    let state : String?
    let country : String?
    let email : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case company_name = "company_name"
        case filesource = "filesource"
        case company_website = "company_website"
        case service = "service"
        case company_size = "company_size"
        case short_description_of_service = "short_description_of_service"
        case contact_person = "contact_person"
        case street_address = "street_address"
        case city = "city"
        case state = "state"
        case country = "country"
        case email = "email"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        filesource = try values.decodeIfPresent(String.self, forKey: .filesource)
        company_website = try values.decodeIfPresent(String.self, forKey: .company_website)
        service = try values.decodeIfPresent(String.self, forKey: .service)
        company_size = try values.decodeIfPresent(String.self, forKey: .company_size)
        short_description_of_service = try values.decodeIfPresent(String.self, forKey: .short_description_of_service)
        contact_person = try values.decodeIfPresent(String.self, forKey: .contact_person)
        street_address = try values.decodeIfPresent(String.self, forKey: .street_address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
