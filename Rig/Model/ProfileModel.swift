//
//  ProfileModel.swift
//  Rig
//
//  Created by Mac on 22/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation



// MARK: - ProfileV
struct ProfileV: Codable {
    let id: Int?
    let firstName, lastName, email, coverImage: String?
    let profileImage: String?
    let about: String?
    let isPremium, isRequestSent, isFriend: Bool?
    let country: String?
    let totalAppliedJobs, totalShortLists, totalCvView: Int?
    let designation: Designation?
    let skills: [JobSkill]?
//    let jobDetails: [JobDetails]?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case coverImage = "cover_image"
        case profileImage = "profile_image"
        case about
        case isPremium = "is_premium"
        case isRequestSent = "is_request_sent"
        case isFriend = "is_friend"
        case country
        case totalAppliedJobs = "total_applied_jobs"
        case totalShortLists = "total_short_lists"
        case totalCvView = "total_cv_view"
//        case jobDetails = "jobs"
        case designation, skills
    }
}

