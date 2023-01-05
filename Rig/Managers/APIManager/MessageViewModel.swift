//
//  MessagesAPi's.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-06-27.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire

class MessageViewModel {
    
    static let shared: MessageViewModel = MessageViewModel()
    
    func inboxChats (completion: @escaping ([GetInboxChat]) -> Void) {
        HTTPManager.shared.get(APIURLs.inboxChat.rawValue) { (response: GenericModel<GetInboxChat>?) in
            guard let response = response else { return }
            if response.status == 200 {
                let getInboxChat = response.data ?? []
                completion(getInboxChat)
            } else {
                print("something went wrong")
                completion([])
            }
        }
    }
    
    func refreshTime (completion: @escaping ((RefreshTime)?) -> Void) {
        HTTPManager.shared.get(APIURLs.refreshTime.rawValue) { (response: GenericModelWithoutArray<RefreshTime>?) in
            guard let resp = response else { return }
            if resp.status == 200 {
                if let getRefreshTime = resp.data {
                    completion(getRefreshTime)
                }
            } else {
                print("something went wrong")
                completion(nil)
            }
        }
    }
    
    
    
    
    func UserChat (id: Int, completion: @escaping ([GetUserChat]) -> Void) {
        HTTPManager.shared.get(APIURLs.userChat.rawValue+"?sender_id=\(id)") { (response: GenericModel<GetUserChat>?) in
            guard let response = response else { return }
            if response.status == 200 {
                let getUserChat = response.data ?? []
                completion(getUserChat)
            } else {
                print("something went wrong")
                completion([])
            }
        }
    }
    
    
    func saveChatToServer (rec_id: Int, message: String, completion: @escaping ([GetUserChat]) -> Void) {
        
        let params = [
            "receiver_id": rec_id,
            "message": message
        ] as [String: Any]
        
        
        HTTPManager.shared.post(APIURLs.storeMessages.rawValue, withparams: params, noHeaders: false) { (response: GenericModel<GetUserChat>?) in
            guard let response = response else {return }
            if response.status == 200 {
                print(response.data)
                let savedChat = response.data ?? []
                completion(savedChat)
                print(savedChat)
            } else {
                print("ERROR TO DECODING")
                completion([])
            }
        }
    }
}


struct GetInboxChat : Codable {
    let count : Int?
    let message : String?
    let created_at : String?
    let reciverdetail : Reciverdetail?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case message = "message"
        case created_at = "created_at"
        case reciverdetail = "reciverdetail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        reciverdetail = try values.decodeIfPresent(Reciverdetail.self, forKey: .reciverdetail)
    }

}

struct Reciverdetail : Codable {
    let id : Int?
    let name : String?
    let profile_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }

}


struct GetUserChat : Codable {
    let id : Int?
    let message : String?
    let is_read : Int?
    let created_at : String?
    let reciver : Reciver?
    let sender : Sender?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case message = "message"
        case is_read = "is_read"
        case created_at = "created_at"
        case reciver = "reciver"
        case sender = "sender"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        is_read = try values.decodeIfPresent(Int.self, forKey: .is_read)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        reciver = try values.decodeIfPresent(Reciver.self, forKey: .reciver)
        sender = try values.decodeIfPresent(Sender.self, forKey: .sender)
    }

}


struct Reciver : Codable {
    let id : Int?
    let name : String?
    let profile_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }

}

struct Sender : Codable {
    let id : Int?
    let name : String?
    let profile_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case profile_image = "profile_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
    }

}

struct RefreshTime : Codable {
    let id : Int?
    let user_type : Int?
    let first_name : String?
    let last_name : String?
    let refresh_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_type = "user_type"
        case first_name = "first_name"
        case last_name = "last_name"
        case refresh_time = "refresh_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        refresh_time = try values.decodeIfPresent(String.self, forKey: .refresh_time)
    }

}




