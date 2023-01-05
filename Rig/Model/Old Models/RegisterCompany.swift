//
//  RegisterCompany.swift
//  Rig
//
//  Created by Ale on 12/7/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class RegisterCompany : Codable {
    let status : String?
    let message : String?
    let company : CompanyDetail?

    enum CodingKeys: String, CodingKey {

        case status = "Status"
        case message = "message"
        case company = "Company"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        company = try values.decodeIfPresent(CompanyDetail.self, forKey: .company)
    }

}

class CompanyDetail : Codable {
    let companyID : Int?
    let companyName : String?
    let profileImage : String?

    enum CodingKeys: String, CodingKey {

        case companyID = "CompanyID"
        case companyName = "CompanyName"
        case profileImage = "ProfileImage"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        companyID = try values.decodeIfPresent(Int.self, forKey: .companyID)
        companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }

}
