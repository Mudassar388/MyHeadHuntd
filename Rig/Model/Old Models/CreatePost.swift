//
//  CreatePost.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class CreatePost: Codable {
    let status, message: String?
    let data: CPData?

    required init(status: String?, message: String?, data: CPData?) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class CPData: Codable {
    let userID, postID, message: String?
    let file: String?
    let dataDescription, isImage: String?
    let createdAt: CreatedAt?

    required init(userID: String?, postID: String?, message: String?, file: String?, dataDescription: String?, isImage: String?, createdAt: CreatedAt?) {
        self.userID = userID
        self.postID = postID
        self.message = message
        self.file = file
        self.dataDescription = dataDescription
        self.isImage = isImage
        self.createdAt = createdAt
    }
}

// MARK: - CreatedAt
class CreatedAt: Codable {
    let date: String?
    let timezoneType: Int?
    let timezone: String?

    required init(date: String?, timezoneType: Int?, timezone: String?) {
        self.date = date
        self.timezoneType = timezoneType
        self.timezone = timezone
    }
}
