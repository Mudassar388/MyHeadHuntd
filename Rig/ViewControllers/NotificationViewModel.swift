//
//  NotificationViewModel.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-08-30.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class NotificationViewModel {

    static let shared: NotificationViewModel = NotificationViewModel()

    func sendPushTest (type: String ,completion: @escaping (NotificationModel) -> Void) {
        let userDevice = UserDefaults.standard.string(forKey: "deviceID")
        print(userDevice as Any)
        let body = [
            "device_token": userDevice as Any,
            "type": type
        ] as [String: Any]


        HTTPManager.shared.post(APIURLs.sendPushTest.rawValue, withparams: body ) { (response: GenericModelWithoutArray<NotificationModel>?) in

            guard let response = response else { return }
            if response.status == 200 {
                let getfriendrequestModel = response.data
                print(">>>>>>",getfriendrequestModel)
            } else {
                print("something went wrong")

            }
        }
    }
}
