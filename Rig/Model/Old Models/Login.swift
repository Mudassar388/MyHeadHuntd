struct Login: Codable {
    let status: Int
    let message: String?
    let data: UserModel?

    init() {
        status = Utilities.Constants.intOValue
        message = Utilities.Constants.blankValue
        data = UserModel()
        
    }
    init(status: Int, data: UserModel, message: String) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
    
    // Encode data
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
        try container.encode(data, forKey: .data)
    }

//        / Creates a new instance by decoding from the given decoder.
//       / - Parameter decoder: the decoder to read data from.
//       / - Throws: This initializer throws an error if reading from the decoder fails, or if the data read is corrupted or otherwise invalid.
     init(from decoder: Decoder) throws {
        //  Returns the data stored in this decoder as represented in a container keyed by the given key type.
        let values = try decoder.container(keyedBy: CodingKeys.self)

        /// Decodes a value of the given type for the given key, if present.
        /// - throws: `DecodingError.typeMismatch` if the encountered encoded value  is not convertible to the requested type.
        self.status = try values.decode(Int.self, forKey: .status)
        self.message = try values.decode(String.self, forKey: .message)
        self.data = try values.decode(UserModel.self, forKey: .data)
    }
}
