//
//  JobDetails.swift
//  Rig
//
//  Created by Mac on 13/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

// MARK: - JobDetails
struct JobDetails: Codable {
    let id, loadID, companyID: Int?
    let title, companyName, dataDescription, functionalArea: String?
    let totalMatchedSkills: Int?
    let postedAt, currency: String?
    let minSalary, maxSalary: Int?
    let isFavourite: Bool?
    let minExperience: String?
    let industry: IndustryData?
    let isApplied: Bool?
    let education, jobType, gender, jobShift: String?
    let jobLocation: String?
    let totalPositions: Int?
    let lastApplyDate: String?
    let skills: [JobSkill]?

    enum CodingKeys: String, CodingKey {
        case id
        case loadID = "load_id"
        case companyID = "company_id"
        case title
        case companyName = "company_name"
        case dataDescription = "description"
        case functionalArea = "functional_area"
        case totalMatchedSkills = "total_matched_skills"
        case postedAt = "posted_at"
        case currency
        case minSalary = "min_salary"
        case maxSalary = "max_salary"
        case isFavourite = "is_favourite"
        case minExperience = "min_experience"
        case industry
        case isApplied = "is_applied"
        case education
        case jobType = "job_type"
        case gender
        case jobShift = "job_shift"
        case jobLocation = "job_location"
        case totalPositions = "total_positions"
        case lastApplyDate = "last_apply_date"
        case skills
    }
    
}

// MARK: - IndustryData
public struct IndustryData: Codable {
    let id: Int?
    let name: String?
}

// MARK: - JobSkill
struct JobSkill: Codable {
    let id: Int?
    let title: String?
}
