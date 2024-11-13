//
//  Notification.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/03/24.
//

import Foundation

struct Api_Notification : Codable {
    let unseen_notification : Unseen_notification?
    let result : [Res_Notification]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case unseen_notification = "unseen_notification"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        unseen_notification = try values.decodeIfPresent(Unseen_notification.self, forKey: .unseen_notification)
        result = try values.decodeIfPresent([Res_Notification].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Unseen_notification : Codable {

//    enum CodingKeys: String, CodingKey {
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }

}

struct Res_Notification : Codable {
    let id : String?
    let user_id : String?
    let request_id : String?
    let title : String?
    let title_fr : String?
    let message : String?
    let message_fr : String?
    let type : String?
    let notification_type : String?
    let seen_status : String?
    let code : String?
    let update_field : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case request_id = "request_id"
        case title = "title"
        case title_fr = "title_fr"
        case message = "message"
        case message_fr = "message_fr"
        case type = "type"
        case notification_type = "notification_type"
        case seen_status = "seen_status"
        case code = "code"
        case update_field = "update_field"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        request_id = try values.decodeIfPresent(String.self, forKey: .request_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        title_fr = try values.decodeIfPresent(String.self, forKey: .title_fr)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        message_fr = try values.decodeIfPresent(String.self, forKey: .message_fr)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        notification_type = try values.decodeIfPresent(String.self, forKey: .notification_type)
        seen_status = try values.decodeIfPresent(String.self, forKey: .seen_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        update_field = try values.decodeIfPresent(String.self, forKey: .update_field)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
