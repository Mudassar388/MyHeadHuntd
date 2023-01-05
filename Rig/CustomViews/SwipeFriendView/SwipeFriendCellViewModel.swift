//
//  SwipeFriendCellViewModel.swift
//  Rig
//
//  Created by Mac on 10/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit
struct SwipeFriendCellViewModel{
    var profileViewModelCell = ProfileViewModel()
    var socialize : SocializeData?
    var viewController:UIViewController?
    init(socialize: SocializeData? ,viewController:UIViewController?)
        {
            self.viewController = viewController
            self.socialize = socialize
        }

}
