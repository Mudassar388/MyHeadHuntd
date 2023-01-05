//
//  SharedModel.swift
//  Rig
//
//  Created by STC Macbook Pro on 24/03/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import Foundation
import UIKit
class SharedModel {
    static let sharedInstance = SharedModel()  // singleton object

    init() {
        // do initial setup or establish an initial connection
    }

    func setStatusBarColor() {
        // do some operations
        let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
        // statusBar.backgroundColor = UIColor(red: 0.00, green: 0.49, blue: 0.51, alpha: 1.00)
        statusBar.backgroundColor = UIColor(named: "greenColor")
            statusBar.tag = 100
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
    }
}
