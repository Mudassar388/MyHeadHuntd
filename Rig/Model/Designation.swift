//
//  Desination.swift
//  Rig
//
//  Created by Mac on 10/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
// MARK: - Designation
struct Designation: Codable {
    let id: Int?
    let title: String?
    enum CodingKeys: String, CodingKey {
       case  id
       case  title = "title"
    }
}
