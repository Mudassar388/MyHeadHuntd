/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct EditProfile : Codable {
    let id : Int?
    let user_type : Int?
    let first_name : String?
    let last_name : String?
    let refresh_time : String?
    let profile_image : String?
    let cover_image : String?
    let email : String?
    let is_new : Bool?
    let cv_uploaded : Bool?
    let skills_exists : Bool?
    let login_token : String?
    let reference_code : String?
    let add_membership_reffernces : Bool?
    let is_premium : Bool?
    let total_applied_jobs : Int?
    let total_short_lists : Int?
    let total_cv_view : Int?
    let designation : DesignationEditProfile?
//	let skills : [JobSkills]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_type = "user_type"
		case first_name = "first_name"
		case last_name = "last_name"
		case refresh_time = "refresh_time"
		case profile_image = "profile_image"
		case cover_image = "cover_image"
		case email = "email"
		case is_new = "is_new"
		case cv_uploaded = "cv_uploaded"
		case skills_exists = "skills_exists"
		case login_token = "login_token"
		case reference_code = "reference_code"
		case add_membership_reffernces = "add_membership_reffernces"
		case is_premium = "is_premium"
		case total_applied_jobs = "total_applied_jobs"
		case total_short_lists = "total_short_lists"
		case total_cv_view = "total_cv_view"
		case designation = "designation"
//		case skills = "skills"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		refresh_time = try values.decodeIfPresent(String.self, forKey: .refresh_time)
		profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		is_new = try values.decodeIfPresent(Bool.self, forKey: .is_new)
		cv_uploaded = try values.decodeIfPresent(Bool.self, forKey: .cv_uploaded)
		skills_exists = try values.decodeIfPresent(Bool.self, forKey: .skills_exists)
		login_token = try values.decodeIfPresent(String.self, forKey: .login_token)
		reference_code = try values.decodeIfPresent(String.self, forKey: .reference_code)
		add_membership_reffernces = try values.decodeIfPresent(Bool.self, forKey: .add_membership_reffernces)
		is_premium = try values.decodeIfPresent(Bool.self, forKey: .is_premium)
		total_applied_jobs = try values.decodeIfPresent(Int.self, forKey: .total_applied_jobs)
		total_short_lists = try values.decodeIfPresent(Int.self, forKey: .total_short_lists)
		total_cv_view = try values.decodeIfPresent(Int.self, forKey: .total_cv_view)
		designation = try values.decodeIfPresent(DesignationEditProfile.self, forKey: .designation)
//		skills = try values.decodeIfPresent([JobSkills].self, forKey: .skills)
	}

}


struct DesignationEditProfile : Codable {
    let id : Int?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}

struct JobSkills : Codable {
    let id : Int?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
    struct userskills : Codable {
        let id : Int?
        let title : String?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case title = "title"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            title = try values.decodeIfPresent(String.self, forKey: .title)
        }
}



struct uploadImageModel : Codable {
    let profile_image : String?
    let cover_image : String?

    enum CodingKeys: String, CodingKey {

        case profile_image = "profile_image"
        case cover_image = "cover_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
    }

}
