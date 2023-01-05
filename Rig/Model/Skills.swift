//
//  Skills.swift
//  Rig
//
//  Created by Sajjad Malik on 20.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

class Skills: Codable {
    let status: Int
    let message: String?

    init(status: Int, message: String) {
        self.status = status
        self.message = message
    }
}
