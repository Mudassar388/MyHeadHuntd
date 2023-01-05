//
//  APIResponse.swift
//  FAB
//
//  Created by Ale on 10/8/20.
//

import Foundation

struct APIResponse<T: Codable> : Codable {
   // let message : String!
    let status : String!
    let data : T?

    enum CodingKeys: String, CodingKey {
       // case message = "message"
        case status = "status"
        case data = "data"
    }
}
