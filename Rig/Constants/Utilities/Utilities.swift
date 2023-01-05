//
//  Utilities.swift
//  Rig
//
//  Created by Sajjad Malik on 30.12.21.
//  Copyright © 2021 Ale. All rights reserved.
//

import Foundation
import UIKit

struct Utilities {
    
    struct Constants {
        
        // General App Constants
        static let appName = "Headhuntd"
        static let footerSize: CGFloat = 200
        static let success = "Success"
        static let appCornerRadius: CGFloat = 0
        static let firstAction = 0
        
        // General Strings
        static let blankValue = ""
        static let intOValue = 0
        static let stringToDoubleFormate = "%f"
        static let double0Value = 0.0
        static let float0Value: Float = 0.0
        static let falseValue = false
        static let trueValue = true
        
        // General String
        static let WaringStr = ""
        static let InfoStr = "Info!"
        static let ErrorStr = ""
        
        static let dummyText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
    }
    
    struct Defaults {
        static let userData = "userData"
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let userRole = "userRole"
        static let userHome = "userHome"
        static let template = "template"
    }
}
