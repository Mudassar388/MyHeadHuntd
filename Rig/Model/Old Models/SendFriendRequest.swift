//
//  SendFriendRequest.swift
//  Rig
//
//  Created by Ale on 10/26/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class SendFriendRequest: Codable {
    let status, message: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }

    required init(status: String?, message: String?) {
        self.status = status
        self.message = message
    }
}
