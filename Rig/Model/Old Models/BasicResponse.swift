//
//  BasicResponse.swift
//  Rig
//
//  Created by Ale on 11/23/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import Foundation

class BasicResponse: Codable {
    let response, message: String?
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
        case message = "message"
    }

    required init(response: String?, message: String?) {
        self.response = response
        self.message = message
    }
}

