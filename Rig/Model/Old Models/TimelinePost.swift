//
//  TimelinePost.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class TimelinePost : Codable {
    let status : String?
    let message : String?
    let posts : [Posts]?

    enum CodingKeys: String, CodingKey {

        case status = "Status"
        case message = "message"
        case posts = "Posts"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        posts = try values.decodeIfPresent([Posts].self, forKey: .posts)
    }

}

class Posts : Codable {
    let postUserID : String?
    let postUserF_name : String?
    let postUserL_name : String?
    let postUserimage : String?
    let country : String?
    let designation : String?
    let postID : String?
    let description : String?
    let file : String?
    let rating : String?
    let isRated : String?
    let comments : [Comments]?

    enum CodingKeys: String, CodingKey {

        case postUserID = "PostUserID"
        case postUserF_name = "PostUserF_name"
        case postUserL_name = "PostUserL_name"
        case postUserimage = "PostUserimage"
        case country = "Country"
        case designation = "Designation"
        case postID = "PostID"
        case description = "Description"
        case file = "File"
        case rating = "Rating"
        case isRated = "IsRated"
        case comments = "Comments"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postUserID = try values.decodeIfPresent(String.self, forKey: .postUserID)
        postUserF_name = try values.decodeIfPresent(String.self, forKey: .postUserF_name)
        postUserL_name = try values.decodeIfPresent(String.self, forKey: .postUserL_name)
        postUserimage = try values.decodeIfPresent(String.self, forKey: .postUserimage)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        postID = try values.decodeIfPresent(String.self, forKey: .postID)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        isRated = try values.decodeIfPresent(String.self, forKey: .isRated)
        comments = try values.decodeIfPresent([Comments].self, forKey: .comments)
    }

}

class Comments : Codable {
    let commentUserID : String?
    let commentUserFname : String?
    let commentUserLname : String?
    let commentUserimage : String?
    let comment : String?

    enum CodingKeys: String, CodingKey {

        case commentUserID = "CommentUserID"
        case commentUserFname = "CommentUserFname"
        case commentUserLname = "CommentUserLname"
        case commentUserimage = "CommentUserimage"
        case comment = "Comment"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commentUserID = try values.decodeIfPresent(String.self, forKey: .commentUserID)
        commentUserFname = try values.decodeIfPresent(String.self, forKey: .commentUserFname)
        commentUserLname = try values.decodeIfPresent(String.self, forKey: .commentUserLname)
        commentUserimage = try values.decodeIfPresent(String.self, forKey: .commentUserimage)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
    }
}
