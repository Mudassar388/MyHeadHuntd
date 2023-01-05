//
//  Typealias.swift
//  Rig
//
//  Created by Sajjad Malik on 30.12.21.
//  Copyright © 2021 Ale. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - TypeAlias for data type
typealias Params = [String: Any]

// MARK: - Completion Block
typealias CompletionNetwork = (_ success: Bool, _ result: JSON) -> Void
typealias GenericNetworkCompletion = (_ success: Bool, _ message: String) -> Void
