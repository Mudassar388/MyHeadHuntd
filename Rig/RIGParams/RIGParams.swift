//
//  RIGParams.swift
//  Rig
//
//  Created by Mac on 09/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation



struct LoginParams: Codable{
    var Email:String?
    var Password:String?
    var UserType:Int?
    var FCMToken:String?
    enum CodingKeys: String, CodingKey {
        case Email = "email"
        case Password = "password"
        case UserType = "user_type"
        case FCMToken = "fcm_token"
    }

}
struct ForgetPasswordParams: Codable{
    var Email:String?
    enum CodingKeys: String, CodingKey {
        case Email = "email"
    }

}
struct CompanySignUpParams: Codable{
        var UserType,JobType,IndustryId,JobDesignationID:Int?
        var FirstName,LastName,Email,Password,Country,CompanyName:String?
        var WebsiteUrl,CompanySize,Address,Description,ContactPerson,FCMToken:String?
    enum CodingKeys: String, CodingKey
    {
        case UserType = "user_type"
        case FirstName = "first_name"
        case LastName = "last_name"
        case Email = "email"
        case Password = "password"
        case Country = "country"
        case JobType = "job_type"
        case CompanyName = "company_name"
        case WebsiteUrl = "website_url"
        case CompanySize = "company_size"
        case IndustryId = "industry_id"
        case Address = "address"
        case Description = "description"
        case JobDesignationID = "job_designation_id"
        case ContactPerson = "contact_person"
        case FCMToken = "fcm_token"

    }
}
struct UserSignUpParams: Codable{
        var UserType,JobDesignationID:Int?
        var FirstName,LastName,Email,Password,Country:String?
        var FCMToken:String?
    enum CodingKeys: String, CodingKey
    {
        case UserType = "user_type"
        case FirstName = "first_name"
        case LastName = "last_name"
        case Email = "email"
        case Password = "password"
        case Country = "country"
        case JobDesignationID = "job_designation_id"
        case FCMToken = "fcm_token"

    }
}

struct PostJobParams:Codable{
    var TotalPositions,JobType,JobShift,Gender,MinExperience,
        MinSalary,MaxSalary,SalaryCurrency,TotalVacancies,Industry:Int?
    var CompanyName,JobTitle,FunctionalArea,Location,
        EducationLevel,description,CareerLevel,LastApplyDate:String?
    var skills: [Int]?
enum CodingKeys: String, CodingKey
{
    case CompanyName          = "company_name"
    case JobTitle             = "job_title"
    case FunctionalArea       = "functional_area"
    case TotalPositions       = "total_positions"
    case JobType              = "job_type"
    case JobShift             = "job_shift"
    case Location             = "location"
    case Gender               = "gender"
    case EducationLevel       = "education_level"
    case MinExperience        = "min_experience"
    case SalaryCurrency       = "salary_currency"
    case MinSalary            = "min_salary"
    case MaxSalary            = "max_salary"
    case CareerLevel          = "career_level"
    case LastApplyDate        = "last_apply_date"
    case TotalVacancies       = "total_vacancies"
    case Industry             = "industry"
    case description          = "description"
    case skills
}
    init()
    {
        CompanyName = nil
        JobTitle = nil
        FunctionalArea = nil
        TotalPositions = nil
        JobType = nil
        JobShift = nil
        Location =  nil
        Gender = nil
        EducationLevel = nil
        MinExperience = nil
        SalaryCurrency = nil
        MinSalary = nil
        MaxSalary = nil
        CareerLevel = nil
        LastApplyDate  =  nil
        TotalVacancies = nil
        Industry   = nil
        skills = nil

    }
}

struct JobFeedParams: Codable{

        var lastID:Int?
        var location:String?
        var experience:Int?
        var jobType:Int?
        var careerLevel:String?
        var gender:Int?
        var sortOrder:Int?

    enum CodingKeys: String, CodingKey
    {
        case lastID = "last_id"
        case location = "location"
        case experience = "experience"
        case jobType = "job_type"
        case careerLevel = "career_level"
        case gender = "gender"
        case sortOrder = "sort_order"

    }
}
struct SocializerParams: Codable{
    var offset:Int?
    enum CodingKeys: String, CodingKey {
    case offset = "offset"
    }

}
struct FavouriteJobsParams: Codable{
    var UserID:Int?
    enum CodingKeys: String, CodingKey {
    case UserID = "user_id"
    }

}
struct IndustrySkillParams: Codable{
    var type:String?
    enum CodingKeys: String, CodingKey {
    case type = "type"
    }

}
struct MarkFavouriteParams: Codable{
    var jobID:Int?
    enum CodingKeys: String, CodingKey {
    case jobID = "job_id"
    }

}
struct PagesParam: Codable{
    var slug:String?
    enum CodingKeys: String, CodingKey {
    case slug = "slug"
    }

}
 
struct AboutPageParams: Codable{
    var page:String?
    enum CodingKeys: String, CodingKey {
    case page = "page"
    }

}
struct ToggleFriendRequestParams: Codable{
    var id:Int?
    var status:String?
    enum CodingKeys: String, CodingKey {
        case id     = "id"
        case status = "status"
    }

}
struct PDFUplaodParams: Decodable{
    var DocTitle:String?
    var Doc:Data?
    enum CodingKeys: String, CodingKey {
        case DocTitle  = "type"
        case Doc = "doc"
    }

}


struct SentFriendRequestParams: Codable{
    var requestTo:Int?
    enum CodingKeys: String, CodingKey {
        case requestTo = "request_to"
    }

}

struct ApplyJobParams: Codable{
    var jobID:Int?
    enum CodingKeys: String, CodingKey {
    case jobID = "job_id"
    }

}
struct JobDetailsParams: Codable{
    var jobID:Int?
    enum CodingKeys: String, CodingKey {
    case jobID = "job_id"
    }

}
struct AppliedJobsParams: Codable{
    var lastID : Int?
    var limit  : Int?
    enum CodingKeys: String, CodingKey {
    case lastID = "last_id"
        case limit = "limit"
    }

}
struct ProfileVParams: Codable{
    var profileID : Int?
    enum CodingKeys: String, CodingKey {
    case profileID = "profile_id"

    }

}

