//
//  Mark.swift
//  Rig
//
//  Created by Mac on 11/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - markfavouriteData
struct MarkfavouriteData: Codable {
    let jobID: Int?
    let isFavourite: Bool?

    enum CodingKeys: String, CodingKey {
        case jobID = "job_id"
        case isFavourite = "is_favourite"
    }
}
