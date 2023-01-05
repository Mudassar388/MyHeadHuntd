//
//  AllUser.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class AllUser:Codable {
    let status, message: String?
    let users: [AUser]?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "Status"
        case users = "USERS"
    }

    required init(status: String?, message: String?, users: [AUser]?) {
        self.status = status
        self.message = message
        self.users = users
    }
}

// MARK: - User
class AUser:Codable {
    let id: Int?
    let firstName, lastName, email, country: String?
    let designation: String?
    let filesource: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "userID"
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case country = "country"
        case designation = "designation"
        case filesource = "filesource"
    }

    required init(id: Int?, firstName: String?, lastName: String?, email: String?, country: String?, designation: String?, filesource: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.country = country
        self.designation = designation
        self.filesource = filesource
    }
}
