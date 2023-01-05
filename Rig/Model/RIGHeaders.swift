//
//  RIGHeaders.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
struct RIGHeaders: Codable
{
    var accessToken: String?
    enum CodingKeys: String, CodingKey
    {
        case accessToken = "access-token"
    }
}
 
