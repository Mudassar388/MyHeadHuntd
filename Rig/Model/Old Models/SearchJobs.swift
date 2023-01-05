//
//  SearchJobs.swift
//  Rig
//
//  Created by Ale on 11/5/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class SearchJobs : Codable {
    let status : String?
    let message : String?
    let serchresult : [SerchJobresult]?

    enum CodingKeys: String, CodingKey {

        case status = "Status"
        case message = "message"
        case serchresult = "serchresult"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        serchresult = try values.decodeIfPresent([SerchJobresult].self, forKey: .serchresult)
    }

}

class SerchJobresult : Codable {
    let id : Int?
    let company_ID : Int?
    let company_name : String?
    let industry : String?
    let position : String?
    let job_type : String?
    let currency_type : String?
    let salary : String?
    let min_experience : String?
    let max_experience : String?
    let location : String?
    let education_level : String?
    let required_skills : String?
    let job_description : String?
    let status : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case company_ID = "company_ID"
        case company_name = "company_name"
        case industry = "industry"
        case position = "position"
        case job_type = "job_type"
        case currency_type = "currency_type"
        case salary = "salary"
        case min_experience = "min_experience"
        case max_experience = "max_experience"
        case location = "location"
        case education_level = "education_level"
        case required_skills = "required_skills"
        case job_description = "job_description"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        company_ID = try values.decodeIfPresent(Int.self, forKey: .company_ID)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        industry = try values.decodeIfPresent(String.self, forKey: .industry)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        job_type = try values.decodeIfPresent(String.self, forKey: .job_type)
        currency_type = try values.decodeIfPresent(String.self, forKey: .currency_type)
        salary = try values.decodeIfPresent(String.self, forKey: .salary)
        min_experience = try values.decodeIfPresent(String.self, forKey: .min_experience)
        max_experience = try values.decodeIfPresent(String.self, forKey: .max_experience)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        education_level = try values.decodeIfPresent(String.self, forKey: .education_level)
        required_skills = try values.decodeIfPresent(String.self, forKey: .required_skills)
        job_description = try values.decodeIfPresent(String.self, forKey: .job_description)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

