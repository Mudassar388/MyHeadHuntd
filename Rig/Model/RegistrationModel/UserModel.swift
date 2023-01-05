//
//  User.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
        var id, userType: Int?
        var firstName, lastName: String?
        var profileImage: String?
        var coverImage, email: String?
        var isNew, cvUploaded, skillsExists: Bool?
        var loginToken, referenceCode: String?
        var isPremium: Bool?
        var designation: Designation?
    
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
            case designation
        }
    
    }


