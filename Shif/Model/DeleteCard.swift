//
//  DeleteCard.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 05/03/24.
//

import Foundation

struct Api_DeleteCard : Codable {
    let result : Res_DeleteCard?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_DeleteCard.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_DeleteCard : Codable {
    let error : res_Error?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(res_Error.self, forKey: .error)
    }
}

struct res_Error : Codable {
    let message : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
}
