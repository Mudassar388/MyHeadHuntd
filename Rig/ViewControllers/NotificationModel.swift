/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct NotificationModel : Codable {
	let priority : String?
	let content_available : Bool?
	let registration_ids : [String]?
	let data : DataModel?

	enum CodingKeys: String, CodingKey {

		case priority = "priority"
		case content_available = "content_available"
		case registration_ids = "registration_ids"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		priority = try values.decodeIfPresent(String.self, forKey: .priority)
		content_available = try values.decodeIfPresent(Bool.self, forKey: .content_available)
		registration_ids = try values.decodeIfPresent([String].self, forKey: .registration_ids)
		data = try values.decodeIfPresent(DataModel.self, forKey: .data)
	}

}

struct DataModel : Codable {
    let id : Int?
    let type : String?
    let title : String?
    let message : String?
    let sender : SenderModel?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "2"
        case title = "title"
        case message = "message"
        case sender = "sender"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        sender = try values.decodeIfPresent(SenderModel.self, forKey: .sender)
    }
}



struct SenderModel : Codable {
    let id : Int?
    let name : String?
    let picture : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case picture = "picture"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }

}
