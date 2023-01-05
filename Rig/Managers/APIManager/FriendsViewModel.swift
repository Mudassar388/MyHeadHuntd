//
//  FriendsViewModel.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-07-02.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class FriendsViewModel {
    
    static let shared: FriendsViewModel = FriendsViewModel()
    
    func friendData (sortOrder: Int ,lastID: Int, text: String ,completion: @escaping (GetMyFriend?) -> Void) {
        
        HTTPManager.shared.get("\(APIURLs.friends.rawValue)?search=\(text)&last_id=\(lastID)&sort_order=\(sortOrder)")
        {(response: GenericModelWithoutArray<GetMyFriend>?) in
            guard let response = response else { return }
            if response.status == 200 {
                print(response.data as Any)
                let data = response.data
                completion(data)
            } else {
                print("something went wrong")
                completion(nil)
            }
        }
    }
}
