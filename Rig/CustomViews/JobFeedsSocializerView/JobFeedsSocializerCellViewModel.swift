//
//  JobFeedsSocializerCellViewModel.swift
//  Rig
//
//  Created by Mac on 10/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit
struct JobFeedsSocializerCellViewModel
{
    var socializers : [SocializeData]?
    var viewController:UIViewController?
    init(socializers: [SocializeData]?,viewController:UIViewController)
    {
        self.viewController = viewController
        self.socializers = socializers
    }
}
