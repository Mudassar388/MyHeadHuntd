//
//  Repository.swift
//  MyResumeCloud
//
//  Created by Ale on 8/22/20.
//  Copyright © 2020 M.Ali Zafar. All rights reserved.
//

import UIKit
import Foundation

class Repository {

    // MARK: - SignUp User
    class func signUpEmployee(email: String, password: String, country: String, designation: String, completion: @escaping ((_ status: Bool, _ register: Signup?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["first_name": "sajjad" as AnyObject, "last_name": "Malik" as AnyObject, "email": email as AnyObject, "password": password as AnyObject,"country": country as AnyObject,"designation": designation as AnyObject, "token": "" as AnyObject, "user_type": UserType.User.rawValue as AnyObject,]
        API.sendData(url: APIPath.signUpEmployer, params: params, objectType: Signup.self) { data in
            if data?.status == 200 {
                completion(true, data,  "")
            } else {
                completion(false, nil, "")
            }
        }
    }
//    // MARK: - SignUp User
//    class func signUpEmployer(email: String, password: String, country: String, designation: String, completion: @escaping ((_ status: Bool, _ register: Signup?, _ message: String) -> Void)) {
//        let params: [String: AnyObject] = ["first_name": "sajjad" as AnyObject, "last_name": "Malik" as AnyObject, "email": email as AnyObject, "password": password as AnyObject,"country": country as AnyObject,"designation": designation as AnyObject, "token": "" as AnyObject, "user_type": 3 as AnyObject,]
//        API.sendData(url: APIPath.signUpEmployer, params: params, objectType: Signup.self) { data in
//            if data?.status == 200 {
//                let token = data?.data?.login_token
//                RIG.DataManager.companyHeaders?.accessToken = token
//                AppSingleton.shared.saveToken(token: token ?? "")
//                completion(true, data,  "")
//            } else {
//                completion(false, nil, "")
//            }
//        }
//    }

    // MARK: - SignIn User
//    class func signInEmployee(email: String, password: String, completion: @escaping ((_ status: Bool, _ signIn: Login?, _ message: String) -> Void)) {
//        let params: [String: AnyObject] = ["email": email as AnyObject, "password": password as AnyObject]
//        API.sendData(url: APIPath.signInEmployer, params: params, objectType: Login.self) { data in
//            if data?.status == 200 {
//                completion(true, data, data?.message ?? "")
//            } else {
//                completion(false, nil, data?.message ?? "")
//            }
//        }
//    }
//
//    // MARK: - SignIn Comapany
//    class func signInCompany(email: String, password: String, completion: @escaping ((_ status: Bool, _ signIn: Login?, _ message: String) -> Void)) {
//        let params: [String: AnyObject] = ["email": email as AnyObject, "password": password as AnyObject]
//        API.sendData(url: APIPath.signInEmployer, params: params, objectType: Login.self) { data in
//            if data?.status == 200 {
//                completion(true, data, data?.message ?? "")
//            } else {
//                completion(false, nil, data?.message ?? "")
//            }
//        }
//    }
    //MARK: - SignIn Comapany
    class func forgetPassword(email: String, completion: @escaping ((_ status: Bool, _ register: Signup?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["email": email as AnyObject, "token": "" as AnyObject]
        API.sendData(url: APIPath.forgetPassword, params: params, objectType: Signup.self) { data in
            if data?.status == 200 {
                completion(true, data, data?.message ?? "")
            } else {
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK: - Add Skills
    class func addSkills(skill: [String], completion: @escaping ((_ status: Bool, _ register: Skills?, _ message: String) -> Void)) {
        let intArray = skill.map { $0.count}
        var skills: [String] = []
        for i in 0..<intArray.count {
           skills.append("skills[\(i)] = \(intArray[i])")
        }
        let params: [String: AnyObject] = ["skill[]": intArray[0] as AnyObject, "skill[]": intArray[0] as AnyObject, "skill[]": intArray[0] as AnyObject]
        API.sendData(url: APIPath.saveSkills, params: params, objectType: Skills.self, tokenStatus: true) { data in
            if data?.status == 200 {
                completion(true, data, data?.message ?? "")
            } else {
                completion(false, nil, data?.message ?? "")
            }
        }
    }


    // MARK: - Create post
    class func createPost(image: UIImage?, descriptionText: String, completion: @escaping ((_ status: Bool, _ cPost: SendFriendRequest?, _ message: String) -> Void)) {
        let imageData = image?.pngData()?.base64EncodedString(options: .endLineWithCarriageReturn) ?? ""
        let params: [String: AnyObject] = ["user_id": (AppSingleton.shared.currentUser?.data?.id ?? 0) as AnyObject, "description": descriptionText as AnyObject, "photo": ("data:image/jpg;base64," + imageData) as AnyObject]

        API.sendData(url: APIPath.createPost, params: params, objectType: SendFriendRequest.self) { (data) in
            if data?.status == "200"{
                completion(true, nil, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Timeline Posts
    class func timelinePost(userID: Int, completion: @escaping ((_ status: Bool, _ tPost: TimelinePost?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_id": userID as AnyObject]
        API.sendData(url: APIPath.profilePost, params: params, objectType: TimelinePost.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - All Users
    class func getAllUsers(completion: @escaping ((_ status: Bool, _ aUsers: AllUser?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": (AppSingleton.shared.currentUser?.data?.id ?? 0) as AnyObject]
        API.sendData(url: APIPath.allusers, params: params, objectType: AllUser.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Send Friend Reuest
    class func sendFriendRequest(friendId: String, completion: @escaping ((_ status: Bool, _ sRequest: SendFriendRequest?, _ message: String) -> Void)) {
       // let params: [String: AnyObject] = ["user_ID": (Singleton.shared.currentUser?.data?.id ?? 0) as AnyObject, "request_to":friendId as AnyObject]
        let params: [String: AnyObject] = ["request_to":friendId as AnyObject]
        API.sendData(url: APIPath.requestsent, params: params, objectType: SendFriendRequest.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Job Apply
    class func applyJob(jobId: String, completion: @escaping ((_ status: Bool, _ aJobRequest: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject, "job_ID": jobId as AnyObject]
        API.sendData(url: APIPath.jobapply, params: params, objectType: SendFriendRequest.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Post Job
    class func postJob(industry: String, position: String, jobType: String, salary: String, minExperience: String, maxExperience: String, location: String, completion: @escaping ((_ status: Bool, _ pJob: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["company_ID": "\(AppSingleton.shared.currentCompany?.data?.company?.id ?? 0)" as AnyObject, "company_name": "\(AppSingleton.shared.currentCompany?.data?.company?.company_name ?? "")" as AnyObject, "industry":industry as AnyObject, "position": position as AnyObject, "job_type": jobType as AnyObject, "currency_type": "pkr" as AnyObject, "salary": salary as AnyObject, "min_experience":"\(minExperience) year" as AnyObject, "max_experience": "\(maxExperience) year" as AnyObject, "location": location as AnyObject, "education_level": "master" as AnyObject, "required_skills": "swift,objc" as AnyObject , "job_description": "Require a self motivated person to play a vital role for the organization growth" as AnyObject]
        API.sendData(url: APIPath.postjob, params: params, objectType: SendFriendRequest.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Search Individual
    class func searchCandidate(position: String,location: String , completion: @escaping ((_ status: Bool, _ sIndividual: SearchIndividual?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["position": position as AnyObject, "location": location as AnyObject]
        API.sendData(url: APIPath.searchindivdual, params: params, objectType: SearchIndividual.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    // MARK: - Search job
    class func searchJob(jobType: String?, minExperience : String?, maxExperience: String?,location: String?, completion: @escaping ((_ status: Bool, _ sJob: SearchJobs?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["job_type": jobType as AnyObject, "min_experience": minExperience as AnyObject, "max_experience": maxExperience as AnyObject, "location": location as AnyObject]
        API.sendData(url: APIPath.searchjob, params: params, objectType: SearchJobs.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK:- Post comment
    class func postComment(postID: String, comment: String , completion: @escaping ((_ status: Bool, _ pComment: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject, "post_ID": postID as AnyObject, "comment": comment  as AnyObject]
        API.sendData(url: APIPath.comment, params: params, objectType: SendFriendRequest.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    class func postCommentCompany(postID: String, comment: String , completion: @escaping ((_ status: Bool, _ pComment: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentCompany?.data?.company?.id as AnyObject, "post_ID": postID as AnyObject, "comment": comment  as AnyObject]
        API.sendData(url: APIPath.comment, params: params, objectType: SendFriendRequest.self) { data in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK:- Post Rating
    class func postRate(postID: String, rating: String , completion: @escaping ((_ status: Bool, _ pComment: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject, "post_ID": postID as AnyObject, "rating": rating  as AnyObject]
        API.sendData(url: APIPath.rate, params: params, objectType: SendFriendRequest.self) { (data) in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    class func postRateCompany(postID: String, rating: String , completion: @escaping ((_ status: Bool, _ pComment: SendFriendRequest?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject, "post_ID": postID as AnyObject, "rating": rating  as AnyObject]
        API.sendData(url: APIPath.rate, params: params, objectType: SendFriendRequest.self) { (data) in
            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK: - Get all Requests
    class func getNotificationRequest(completion: @escaping ((_ status: Bool, _ notificationResponse: Welcome?, _ message: String) -> Void)) {
       // let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject]
        API.requestDta(url: APIPath.friendrequests, objectType: Welcome.self) { (data) in
            if data?.status == 200 {
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK: - Accept friend request
    class func accpetRejectRequest(friendID: String, status: String ,completion: @escaping ((_ status: Bool, _ notificationResponse: BasicResponse?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject, "friend_ID": friendID as AnyObject, "status": status as AnyObject]
        API.sendData(url: APIPath.friendConfirm, params: params, objectType: BasicResponse.self) { (data) in
            if data?.response == "200"{
                completion(true, nil, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK: - Get All friends
    class func getAllFriends(completion: @escaping ((_ status: Bool, _ friendListResponse: AllFriends?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject]
        API.sendData(url: APIPath.friendsList, params: params, objectType: AllFriends.self) { (data) in

            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    class func getAllCompanyFriends(completion: @escaping ((_ status: Bool, _ friendListResponse: AllFriends?, _ message: String) -> Void)) {
        let params: [String: AnyObject] = ["user_ID": AppSingleton.shared.currentUser?.data?.id as AnyObject]
        API.sendData(url: APIPath.friendsList, params: params, objectType: AllFriends.self) { (data) in

            if data?.status == "200"{
                completion(true, data, data?.message ?? "")
            }else{
                completion(false, nil, data?.message ?? "")
            }
        }
    }

    //MARK: - send connection Request


}
