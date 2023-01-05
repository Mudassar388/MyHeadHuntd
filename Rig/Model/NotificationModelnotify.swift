//
//  NotificationModel.swift
//  Rig
//
//  Created by Sufyan Qasim on 29/10/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
struct Welcome: Codable {
    let status: Int?
    let message : String?
    var data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let createdAt: String?
    let request: RequestBy?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case request = "request_by"
    }
}

// MARK: - RequestBy
struct RequestBy: Codable {
    let id: Int?
    let firstName, lastName: String?
    let profileImage, coverImage: String?
    let designation: Designationdataa?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case designation
    }
}

// MARK: - Designation
struct Designationdataa: Codable {
}
