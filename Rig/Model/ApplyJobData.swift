//
//  ApplyJobData.swift
//  Rig
//
//  Created by Mac on 12/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - ApplyJobData
struct ApplyJobData: Codable {
    let jobID: Int
    let status, appliedAt: String

    enum CodingKeys: String, CodingKey {
        case jobID = "job_id"
        case status
        case appliedAt = "applied_at"
    }
}
