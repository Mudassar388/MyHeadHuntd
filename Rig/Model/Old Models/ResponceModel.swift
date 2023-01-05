//
//  ResponceModel.swift
//  Rig
//
//  Created by Sajjad Malik on 24.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

class ResponceModel: Codable {
    let status: Int?
    let message: String?

    required init(status: Int,message: String) {
        self.status = status
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
