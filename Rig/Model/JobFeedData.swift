//
//  JobFeeds.swift
//  Rig
//
//  Created by Mac on 09/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
struct JobFeedData: Codable {
    // MARK: - JobFeedData
    let total: Int?
    let jobs: [Feeds]?

    enum CodingKeys: String, CodingKey {
        case total =  "total"
        case jobs = "jobs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobs = try values.decodeIfPresent([Feeds].self, forKey: .jobs)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}

struct Feeds1: Codable {
    let id, loadID, companyID: Int?
    let title, companyName, datumDescription, functionalArea: String?
    let totalMatchedSkills: Int?
    let postedAt, currency: String?
    let minSalary, maxSalary: Int?
    let isFavourite: Bool?
    let minExperience: String?
    let industry: Industry?
    let isApplied: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case loadID = "load_id"
        case companyID = "company_id"
        case title
        case companyName = "company_name"
        case datumDescription = "description"
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
    }
    
    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            companyID = try values.decodeIfPresent(Int.self, forKey: .companyID)
            companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
            currency = try values.decodeIfPresent(String.self, forKey: .currency)
            datumDescription = try values.decodeIfPresent(String.self, forKey: .datumDescription)
            functionalArea = try values.decodeIfPresent(String.self, forKey: .functionalArea)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            industry = try Industry(from: decoder)
            isApplied = try values.decodeIfPresent(Bool.self, forKey: .isApplied)
            isFavourite = try values.decodeIfPresent(Bool.self, forKey: .isFavourite)
            loadID = try values.decodeIfPresent(Int.self, forKey: .loadID)
            maxSalary = try values.decodeIfPresent(Int.self, forKey: .maxSalary)
            minExperience = try values.decodeIfPresent(String.self, forKey: .minExperience)
            minSalary = try values.decodeIfPresent(Int.self, forKey: .minSalary)
            postedAt = try values.decodeIfPresent(String.self, forKey: .postedAt)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            totalMatchedSkills = try values.decodeIfPresent(Int.self, forKey: .totalMatchedSkills)
        }
}

// MARK: - Industry
struct Industry: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
        }
    
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            name = try values.decodeIfPresent(String.self, forKey: .name)
        }
}


struct Feeds : Codable {
    let id : Int?
    let load_id : Int?
    let company_id : Int?
    let title : String?
    let company_name : String?
    let description : String?
    let functional_area : String?
    let total_matched_skills : Int?
    let posted_at : String?
    let currency : String?
    let min_salary : Int?
    let max_salary : Int?
    let is_favourite : Bool?
    let min_experience : String?
//    let industry : NewIndustry?
    let is_applied : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case load_id = "load_id"
        case company_id = "company_id"
        case title = "title"
        case company_name = "company_name"
        case description = "description"
        case functional_area = "functional_area"
        case total_matched_skills = "total_matched_skills"
        case posted_at = "posted_at"
        case currency = "currency"
        case min_salary = "min_salary"
        case max_salary = "max_salary"
        case is_favourite = "is_favourite"
        case min_experience = "min_experience"
//        case industry = "industry"
        case is_applied = "is_applied"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        load_id = try values.decodeIfPresent(Int.self, forKey: .load_id)
        company_id = try values.decodeIfPresent(Int.self, forKey: .company_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        functional_area = try values.decodeIfPresent(String.self, forKey: .functional_area)
        total_matched_skills = try values.decodeIfPresent(Int.self, forKey: .total_matched_skills)
        posted_at = try values.decodeIfPresent(String.self, forKey: .posted_at)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        min_salary = try values.decodeIfPresent(Int.self, forKey: .min_salary)
        max_salary = try values.decodeIfPresent(Int.self, forKey: .max_salary)
        is_favourite = try values.decodeIfPresent(Bool.self, forKey: .is_favourite)
        min_experience = try values.decodeIfPresent(String.self, forKey: .min_experience)
//        industry = try values.decodeIfPresent(NewIndustry.self, forKey: .industry)
        is_applied = try values.decodeIfPresent(Bool.self, forKey: .is_applied)
    }

}


struct NewIndustry : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
