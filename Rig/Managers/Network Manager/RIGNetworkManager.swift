//
//  RIGNetworkManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Reachability

class RIGNetworkManager : NSObject
{
    static let sharedInstance = RIGNetworkManager()

    func isNetworkReachable(viewController: UIViewController?) -> Bool
    {
        let reachablity = Reachability.forInternetConnection()
        reachablity?.startNotifier()
        let status = reachablity?.currentReachabilityStatus()

        if status == NetworkStatus.NotReachable
        {
            RIG.UIManager.showAlert(title: "", message: RIGAlerts.ReachabilityErrorMessage, okButton: true, viewController: viewController!) { _ in }
            return false
        }

        else
        {
            return true
        }
    }

}
