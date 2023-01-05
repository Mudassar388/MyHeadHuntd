//
//  AllFriends.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class AllFriends:Codable {
    let status, message: String?
    let friends: [AFriends]?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "Status"
        case friends = "FRIENDS"
    }
    required init(status: String?, message: String?, friends: [AFriends]?) {
        self.status = status
        self.message = message
        self.friends = friends
    }
}

// MARK: - User
class AFriends:Codable {
    let friend_ID: Int?
    let count: Int?
    let friendFname, lastName, email, country: String?
    let designation: String?
    let filesource: String?
    
    enum CodingKeys: String, CodingKey {
        case friend_ID = "fID"
        case count = "count"
        case friendFname = "first_name"
        case lastName = "last_name"
        case email = "email"
        case country = "country"
        case designation = "designation"
        case filesource = "filesource"
    }

    required init(friend_ID: Int?, count: Int?, friendFname: String?, lastName: String?, email: String?, country: String?, designation: String?, filesource: String?) {
        self.friend_ID = friend_ID
        self.count = count
        self.friendFname = friendFname
        self.lastName = lastName
        self.email = email
        self.country = country
        self.designation = designation
        self.filesource = filesource
    }
}
