

import Foundation
struct GenericModel <T: Codable> : Codable {
	let status : Int?
	let data : [T]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		data = try values.decodeIfPresent([T].self, forKey: .data)
	}
}


//struct uploadImageModel : Codable {
//    let status : Int?
//    let message : String?
////    let data : [T]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case status = "status"
////        case data = "data"
//        case message = "message"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
////        data = try values.decodeIfPresent([T].self, forKey: .data)
//    }
//}



struct GenericModelWithoutArray <T: Codable> : Codable {
    let status : Int?
    let data : T?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}


struct Refferal : Codable {
    let status : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
