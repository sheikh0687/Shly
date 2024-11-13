//
//  AddChat.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 02/11/23.
//

import Foundation

struct Api_InsertChat : Codable {
    let result : Res_InsertChat?
    let status : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_InsertChat.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct Res_InsertChat : Codable {
    let id : String?
    let request_id : String?
    let sender_id : String?
    let receiver_id : String?
    let chat_message : String?
    let chat_image : String?
    let timezone : String?
    let date_time : String?
    let status : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case request_id = "request_id"
        case sender_id = "sender_id"
        case receiver_id = "receiver_id"
        case chat_message = "chat_message"
        case chat_image = "chat_image"
        case timezone = "timezone"
        case date_time = "date_time"
        case status = "status"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        sender_id = try values.decodeIfPresent(String.self, forKey: .sender_id)
        receiver_id = try values.decodeIfPresent(String.self, forKey: .receiver_id)
        chat_message = try values.decodeIfPresent(String.self, forKey: .chat_message)
        chat_image = try values.decodeIfPresent(String.self, forKey: .chat_image)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
