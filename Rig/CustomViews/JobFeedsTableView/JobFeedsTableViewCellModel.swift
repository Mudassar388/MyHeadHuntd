//
//  jobfeedtbl.swift
//  Rig
//
//  Created by Mac on 09/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit
//struct JobFeedsTableViewCellModel
//{
//    var jobFeeds : JobFeedData?
//    var viewController:UIViewController?
//    init(jobFeeds: JobFeedData?,viewController: UIViewController?)
//    {   self.viewController = viewController
//        self.jobFeeds = jobFeeds
//    }
//}

struct JobFeedsTableViewCellModel
{
    var jobFeeds : Feeds?
    var viewController:UIViewController?
    init(jobFeeds: Feeds?,viewController: UIViewController?)
    {   self.viewController = viewController
        self.jobFeeds = jobFeeds
    }
}
