//
//  CompanySignUp.swift
//  Rig
//
//  Created by Mac on 16/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - CompanyModel
struct CompanyModel: Codable {
    var id, userType: Int?
    var firstName, lastName: String?
    var profileImage: String?
    var coverImage, email: String?
    var isNew, cvUploaded, skillsExists: Bool?
    var loginToken, referenceCode: String?
    var isPremium: Bool?
    var company: Company?

    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case email
        case isNew = "is_new"
        case cvUploaded = "cv_uploaded"
        case skillsExists = "skills_exists"
        case loginToken = "login_token"
        case referenceCode = "reference_code"
        case isPremium = "is_premium"
        case company
    }
}
 

// MARK: - Company
struct Company: Codable {
    let id: Int?
    let companyName, contactPerson: String?
    let websiteURL: String?
    let companySize, address, companyDescription, companyLogo: String?
    let industry: Industry?
    let totalJobViews, totalShortListCands, totalPostedJobs: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case contactPerson = "contact_person"
        case websiteURL = "website_url"
        case companySize = "company_size"
        case address
        case companyDescription = "description"
        case companyLogo = "company_logo"
        case industry, totalJobViews, totalShortListCands, totalPostedJobs
    }
}

